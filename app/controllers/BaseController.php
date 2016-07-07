<?php

namespace App\Controllers;

use Phalcon\Mvc\Controller;

class BaseController extends Controller
{

	public function initialize()
	{
		$this->response->setContentType('application/json', 'UTF-8');
		$this->response->setStatusCode(200, 'OK');
		$this->view->disable();
	}

	public function notFound404Action()
	{
		$this->response->setStatusCode(404, 'Not Found');
		$this->view->setMainView('error/index');
	}
}