<?php

namespace App\Models;

use Phalcon\Validation;

class UserAttribute extends Base
{
	public $id;
	public $birthdate;
	public $sex;
	public $weight;
	public $height;
	public $push_notification;
	public $modifiedDate;

    public function initialize()
    {
        \Phalcon\Mvc\Model::setup(array(    
            'notNullValidations' => false
        ));

        $this->hasOne("id", "App\Models\UserAttribute", "id", array(
            'alias' => 'User', 'foreignKey' => TRUE
        ));
    }

	public function getSource()
    {
        return "user_attribute";
    }

    public function columnMap()
    {
    	return [
    		'user_id' => 'id',
    		'birthdate' => 'birthdate',
    		'sex' => 'sex',
            'weight' => 'weight',
    		'height' => 'height',
    		'push_notification' => 'pushNotification',
    		'modified_date' => 'modifiedDate',
    	];
    }
}