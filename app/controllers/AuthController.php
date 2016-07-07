<?php

namespace App\Controllers;

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
    	$email = $this->request->get('email', 'email', '');
    	
    }

    /**
     * @AuthMiddleware("App\Libraries\Middleware")
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
}
