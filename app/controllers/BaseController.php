<?php

namespace App\Controllers;

use Phalcon\Mvc\Controller,
	Phalcon\Filter;

class BaseController extends Controller
{
	protected $token;
	protected $filter;

	public function initialize()
	{
		$this->filter = new Filter();
		
		$this->token = $this->request->get('token', ['trim', 'alphanum'], '');
		$this->response->setContentType('application/json', 'UTF-8');
		$this->response->setStatusCode(200, 'OK');
		$this->view->disable();
	}

	public function notFound404Action()
	{
		$this->response->setHeader("Content-Type", "text/plain");
		$this->response->setRawHeader("HTTP/1.1 404 Not Found");
		$this->response->setStatusCode(404, 'Not Found');
		$this->response->setContent('Page Not found');
		$this->response->send();
	}

	public function showErrorAction()
	{
		$msg = $this->dispatcher->getParams('msg');
		$this->response->setJsonContent([
			'code' => 401,
			'message' => $msg['msg'],
			'data' => new \stdClass()
		]);
		$this->response->send();
	}
}