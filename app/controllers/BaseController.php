<?php

namespace App\Controllers;

use Phalcon\Mvc\Controller;

class BaseController extends Controller
{
	public $token;

	public function initialize()
	{
		$this->token = $this->request->get('token', ['trim', 'alphanum'], '');
		$this->response->setContentType('application/json', 'UTF-8');
		$this->response->setStatusCode(200, 'OK');
		$this->view->disable();
	}

	public function notFound404Action()
	{
		$this->response->setStatusCode(404, 'Not Found');
		$this->view->setMainView('error/index');
	}

	public function showErrorAction()
	{
		$msg = $this->dispatcher->getParams('msg');
		$this->response->setJsonContent([
			'status' => 'NOK',
			'message' => $msg['msg'],
			'data' => new \stdClass()
		]);
		$this->response->send();
	}
}