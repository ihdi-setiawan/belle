<?php

namespace App\Models;

use Phalcon\Validation,
	Phalcon\Validation\Validator\PresenceOf;

class User extends Base
{
	public $id;
	public $userName;
	public $email;
	public $password;
	public $firstName;
	public $lastName;
	public $contact;
	public $createdDate;
    public $createdBy;
    public $endedBy;
	public $endedDate;
	public $modifiedDate;

    public function initialize()
    {
        \Phalcon\Mvc\Model::setup(array(    
            'notNullValidations' => false
        ));

        $this->hasOne("id", "App\Models\UserAttribute", "id", array(
            'alias' => 'UserAttribute'
        ));
    }

	public function getSource()
    {
        return "user";
    }

    public function columnMap()
    {
    	return [
    		'user_id' => 'id',
    		'user_name' => 'userName',
    		'email' => 'email',
            'password' => 'password',
    		'first_name' => 'firstName',
    		'last_name' => 'lastName',
    		'contact_no' => 'contact',
    		'created_date' => 'createdDate',
            'created_by' => 'createdBy',
    		'ended_by' => 'endedBy',
            'ended_date' => 'endedDate',
    		'modified_date' => 'modifiedDate',
    	];
    }

    public function validateEmail($email)
    {
    	$validation = new Validation();
    	$validation
    		->add('email', new PresenceOf([
				'message' => 'Email harus diisi',
				'cancelOnFail' => true
    		]))
    		->add('email', new \Phalcon\Validation\Validator\Email([
				'message' => 'Email tidak valid',
				'cancelOnFail' => true
    		]));

    	$message = $validation->validate(['email' => $email]);
    	if (count($message)) {
			return $validation->getMessages()[0]->getMessage();    		
    	}
    	
    	return '';
    }

    private function checkPassword($inputPassword, $password)
    {
        return password_verify($inputPassword, $password);
    }

    private function hashPassword($password)
    {
        $options = [
            'cost' => $this->config['oauth']['cost']
        ];
        return password_hash($password, PASSWORD_DEFAULT, $options);
    }

    private function generateRandomPassword()
    {
    	$an = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        $su = strlen($an) - 1;
        return substr($an, rand(0, $su), 1) .
                substr($an, rand(0, $su), 1) .
                substr($an, rand(0, $su), 1) .
                substr($an, rand(0, $su), 1) .
                substr($an, rand(0, $su), 1) .
                substr($an, rand(0, $su), 1);
    }

    public function forgotPassword($email)
    {
    	if ($this->isExistEmail($email)) {
    		$user = self::findFirst([
    			'column' => 'id',
    			'conditions' => 'email = ?0 AND endedDate > NOW()',
    			'bind' => [$email]
    		]);

    		if ($user && $user->count() > 0) {
                $hash = $this->generateRandomPassword();
                $user->password = $this->hashPassword($hash);
    			
                if ($user->update()) {
    				return [200, 'Password baru telah dikirim ke email Anda', $hash];
	    		} else {
	    			return [204, 'Internal error'];
	    		}
    		}
    	} else {
    		return [204, 'Email tidak valid'];
    	}
    }

    public function isExistEmail($email)
    {
    	$total = self::count([
    			'columns' => 'id',
    			'conditions' => 'email = ?0 AND endedDate > NOW()',
    			'bind' => [$email]
    		]);

    	return ((int)$total > 0);
    }

    public function changePassword($param)
    {
        $validation = new Validation();
        $validation
            ->add('old_password', new PresenceOf([
                'message' => 'Password lama harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('new_password', new PresenceOf([
                'message' => 'Password baru harus diisi',
                'cancelOnFail' => true
            ]));
        
        $message = $validation->validate($param);
        if (count($message)) {
            return [204, $validation->getMessages()[0]->getMessage()];         
        } else {
            $row = self::findFirst([
                'conditions' => 'id = ?0 AND endedDate > NOW()',
                'bind' => [$param['user_id']]
            ]);
            
            if ($row && $row->count() > 0) {
                if ($this->checkPassword($param['old_password'], $row->password)) {
                    $row->password = $this->hashPassword($param['new_password']);
                    if ($row->update()) {
                        return [200, 'Password telah berhasil diganti'];
                    } else {
                        return [204, 'Internal error'];
                    }
                } else {
                    return [204, 'Password lama tidak valid'];    
                }
            } else {
                return [204, 'Internal error'];
            }
        }
    }

    public function registerUser($param)
    {
        $validation = new Validation();
        $validation
            ->add('first_name', new PresenceOf([
                'message' => 'Nama depan harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('first_name', new \Phalcon\Validation\Validator\Regex([
                'pattern' => '/^[a-z]{3,64}+$/',
                'message' => 'Nama depan tidak valid',
                'cancelOnFail' => true
            ]));

        $message = $validation->validate($param);
        if (count($message)) {
            return [204, $validation->getMessages()[0]->getMessage()];         
        }
        
        $validation = new Validation();
        if (!empty($param['last_name'])) {
            $validation
            ->add('last_name', new \Phalcon\Validation\Validator\Regex([
                'pattern' => '/^[a-z]{2,64}+$/',
                'message' => 'Nama belakang tidak valid',
                'cancelOnFail' => true
            ]));
        }

        $validation
            ->add('birthdate', new PresenceOf([
                'message' => 'Tanggal lahir harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('birthdate', new \Phalcon\Validation\Validator\Regex([
                'pattern' => '/^[0-9]{4}[-\/](0[1-9]|1[12])[-\/](0[1-9]|[12][0-9]|3[01])$/',
                'message' => 'Tanggal lahir tidak valid',
                'cancelOnFail' => true
            ]))
            ->add('email', new PresenceOf([
                'message' => 'Email harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('email', new \Phalcon\Validation\Validator\Email([
                'message' => 'Email tidak valid',
                'cancelOnFail' => true
            ]))
            ->add('email', new \Phalcon\Validation\Validator\Uniqueness([
                'model' => '\App\Models\User',
                'attribute' => 'email',
                'message' => 'Email tidak tersedia',
                'cancelOnFail' => true
            ]))
            ->add('password', new PresenceOf([
                'message' => 'Password harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('confirm_password', new PresenceOf([
                'message' => 'Konfirmasi password harus diisi',
                'cancelOnFail' => true
            ]))
            ->add('password', new \Phalcon\Validation\Validator\Confirmation([
                'message' => 'Password harus sesuai dengan konfirmasi password',
                'with' => 'confirm_password',
                'cancelOnFail' => true
            ]))
            ->add('agree', new \Phalcon\Validation\Validator\Regex([
                'pattern' => '/^[1]{1}$/',
                'message' => 'Syarat dan ketentuan harus disetujui',
                'cancelOnFail' => true
            ]));
        
        $message = $validation->validate($param);
        if (count($message)) {
            return [204, $validation->getMessages()[0]->getMessage()];         
        } else {
            //register
            $user = new User();
            $user->userName = $param['username'];
            $user->email = $param['email'];
            $user->password = $this->hashPassword($param['password']);
            $user->firstName = $param['first_name'];
            $user->lastName = $param['last_name'];
            $user->createdDate = new \Phalcon\Db\RawValue('now()');
            $user->endedDate = new \Phalcon\Db\RawValue('default');
            $user->createdBy = new \Phalcon\Db\RawValue('default');
            //$user->contactNo = $param['contact_no'];
            
            if ($user->save()) {
                $userAttr = new UserAttribute();
                $userAttr->birthdate = $param['birthdate'];
                $userAttr->pushNotification = new \Phalcon\Db\RawValue('default');
                $userAttr->modifiedDate = new \Phalcon\Db\RawValue('default');
                $userAttr->id = $user->id;
                $userAttr->save();

                return [200, 'Sukses registrasi'];
            } else {
                return [204, 'Internal error'];
            }
        }
    }
}