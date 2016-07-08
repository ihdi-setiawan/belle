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
    				return ['OK', 'Password baru telah dikirim ke email Anda', $hash];
	    		} else {
	    			return ['NOK', 'Internal error'];
	    		}
    		}
    	} else {
    		return ['NOK', 'Email tidak valid'];
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
            return ['NOK', $validation->getMessages()[0]->getMessage()];         
        } else {
            $row = self::findFirst([
                //'columns' => 'password',
                'conditions' => 'id = ?0 AND endedDate > NOW()',
                'bind' => [$param['user_id']]
            ]);
            
            if ($row && $row->count() > 0) {
                if ($this->checkPassword($param['old_password'], $row->password)) {
                    $row->password = $this->hashPassword($param['new_password']);
                    if ($row->update()) {
                        return ['OK', 'Password telah berhasil diganti'];
                    } else {
                        return ['NOK', 'Internal error'];
                    }
                } else {
                    return ['NOK', 'Password lama tidak valid'];    
                }
            } else {
                return ['NOK', 'Internal error'];
            }
        }
    }
}