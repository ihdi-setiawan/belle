<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Base extends Model
{
	public function initialize() 
	{
		$this->setReadConnectionService('db');
    	$this->setWriteConnectionService('db');
	}
}