<?php

namespace App\Models;

use Phalcon\Mvc\Model;

class Base extends Model
{
	protected $config;

	public function initialize()
	{
		$this->setReadConnectionService('db');
        $this->setWriteConnectionService('db');
		$this->useDynamicUpdate(true);
	}

	public function onConstruct()
	{
		$this->config = $this->getDI()->get('config');
	}
}