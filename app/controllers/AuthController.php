<?php

namespace App\Controllers;

use App\Models\User;

class AuthController extends BaseController
{
	public function loginAction()
	{
		$msg = 'Email and password required';
		
		$result = $this->oauth2->handleTokenRequest($this->requestOAuth);
		if ($result) {
			if ($result->getStatusCode() === 200) {
				$this->response->setJsonContent([
					'status' => 'OK',
					'message' => 'Login success',
					'data' => [
						'token' => $result->getParameter('access_token'),
						'expires_in' => $result->getParameter('expires_in'),
						'user' => $result->getParameter('user'),
					]
				]);
			} else {
				$msg = $result->getStatusText();	
				if ($result->getStatusCode() === 401) {
					$msg = $result->getParameter('error_description');
				}

				$this->response->setJsonContent([
					'status' => 'NOK',
					'message' => $msg,
					'data' => new \stdClass()
				]);
			}
		}

		$this->response->send();
	}

	public function registerAction()
	{
		
	}

    public function forgotAction()
    {
    	$email = $this->request->get('email', ['email', 'trim'], '');
		
		$user = new User();
		$row = $user->forgotPassword($email);
		$this->response->setJsonContent([
			'status' => $row[0],
			'message' => $row[1],
			'data' => new \stdClass()
		]);
		
		if ($row[0] === 'OK') {
			$this->utility->sendMail(
				$email, 
				'Reset Password', 
				'forgot', 
				['password' => $row[2]]
			);
		}

		$this->response->send();
    }

    /**
     * @AuthMiddleware("App\Library\Middleware")
     */
    public function logoutAction()
    {
    	$tokenInfo = $this->registry[$this->token];
    	$this->requestOAuth->request['client_id'] = $tokenInfo['client_id'];
    	$this->requestOAuth->request['user_id'] = $tokenInfo['user_id'];

    	$this->requestOAuth->request['token'] = $this->token;
    	$result = $this->oauth2->handleRevokeRequest($this->requestOAuth);
    	
    	if ($result->getStatusCode() === 200) {
			$this->response->setJsonContent([
				'status' => 'OK',
				'message' => 'Logout success',
				'data' => new \stdClass()
			]);
		} else {
			$msg = $result->getStatusText();
			if ($result->getStatusCode() === 401) {
				$msg = $result->getParameter('error_description');
			}

			$this->response->setJsonContent([
				'status' => 'NOK',
				'message' => $msg,
				'data' => new \stdClass()
			]);
		}

		$this->response->send();
    }

    /**
     * @AuthMiddleware("App\Library\Middleware")
     */
	public function changeAction()
    {
    	$tokenInfo = $this->registry[$this->token];

    	$param['user_id'] = $tokenInfo['user_id'];
    	$param['old_password'] = $this->filter->sanitize($this->requestOAuth->request['old_password'], ['trim', 'striptags'], '');
    	$param['new_password'] = $this->filter->sanitize($this->requestOAuth->request['new_password'], ['trim', 'striptags'], '');
    	
		$user = new User();
		$row = $user->changePassword($param);
		
		$this->response->setJsonContent([
			'status' => $row[0],
			'message' => $row[1],
			'data' => new \stdClass()
		]);

		$this->response->send();
    }
}
