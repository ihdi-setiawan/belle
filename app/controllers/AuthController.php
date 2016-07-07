<?php

namespace App\Controllers;

class AuthController extends BaseController
{

	public function loginAction()
	{
		$result = $this->oauth2->handleTokenRequest($this->requestOAuth);
		if ($result) {
			if ($result->getStatusCode() === 200) {
				//save device token
				
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
					'data' => []
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
}
