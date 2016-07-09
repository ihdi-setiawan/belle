<?php

namespace App\Controllers;

use App\Models\User;

class AuthController extends BaseController
{
	private function callOauth($request)
	{
		$response = [];
		$result = $this->oauth2->handleTokenRequest($request);
		if ($result) {
			if ($result->getStatusCode() === 200) {
				$response = [
					'code' => 200,
					'message' => 'Login success',
					'data' => [
						'token' => $result->getParameter('access_token'),
						'expires_in' => $result->getParameter('expires_in'),
						'user' => $result->getParameter('user'),
					]
				];
			} else {
				$msg = $result->getStatusText();	
				if ($result->getStatusCode() === 401) {
					$msg = $result->getParameter('error_description');
				}

				$response = [
					'code' => 204,
					'message' => $msg,
					'data' => new \stdClass()
				];
			}
		}

		return $response;
	}

	public function loginAction()
	{
		$msg = 'Email dan password harus diisi';
		$deviceToken = isset($this->requestOAuth->request['device_token']) ? $this->requestOAuth->request['device_token'] : '';
    	if (empty($deviceToken)) {
    		$this->requestOAuth->request['device_token'] = $deviceToken;
    	}

		$result = $this->callOauth($this->requestOAuth);
		$this->response->setJsonContent($result);
		$this->response->send();
	}

	public function registerAction()
	{
		$firstName = isset($this->requestOAuth->request['first_name']) ? $this->requestOAuth->request['first_name'] : '';
		$lastName = isset($this->requestOAuth->request['last_name']) ? $this->requestOAuth->request['last_name'] : '';
		$email = isset($this->requestOAuth->request['email']) ? $this->requestOAuth->request['email'] : '';
		$username = isset($this->requestOAuth->request['username']) ? $this->requestOAuth->request['username'] : '';
		
		$birthdate = '';
		if (isset($this->requestOAuth->request['birthdate']) && !empty($this->requestOAuth->request['birthdate'])) {
			$inputDate = $this->requestOAuth->request['birthdate'];
			$inputDate = explode('-', $inputDate);
			if (count($inputDate) !==  3) {
				//set to make invalid
				$birthdate = '00-00-00';
			} else {
				$birthdate = $inputDate[2] . '-' . $inputDate[1] . '-' . $inputDate[0];
			}
		}
		
		$password = isset($this->requestOAuth->request['password']) ? $this->requestOAuth->request['password'] : '';
		$confirmPassword = isset($this->requestOAuth->request['confirm_password']) ? $this->requestOAuth->request['confirm_password'] : '';
		$agree = isset($this->requestOAuth->request['agree']) ? $this->requestOAuth->request['agree'] : 0;

		$param['first_name'] = $this->filter->sanitize(strtolower($firstName), ['trim', 'striptags'], '');
    	$param['last_name'] = $this->filter->sanitize(strtolower($lastName), ['trim', 'striptags'], '');	
		$param['email'] = $this->filter->sanitize($email, ['trim', 'email'], '');
		$param['username'] = $this->filter->sanitize($username, ['trim', 'striptags'], '');
		$param['birthdate'] = $this->filter->sanitize($birthdate, ['trim', 'string', 'striptags'], '');
		$param['password'] = $this->filter->sanitize($password, ['trim', 'alphanum'], '');
		$param['confirm_password'] = $this->filter->sanitize($confirmPassword, ['trim', 'alphanum'], '');
		$param['agree'] = $this->filter->sanitize($agree, ['trim', 'int'], 0);
		
		$user = new User();
		$result = $user->registerUser($param);
		if ($result[0] !== 200) {
			$this->response->setJsonContent([
				'code' => $result[0],
				'message' => $result[1],
				'data' => new \stdClass()
			]);
		} else {
			//call oauth
			$deviceToken = isset($this->requestOAuth->request['device_token']) ? $this->requestOAuth->request['device_token'] : '';
	    	if (empty($deviceToken)) {
	    		$this->requestOAuth->request['device_token'] = $deviceToken;
	    	}
	    	$result = $this->callOauth($this->requestOAuth);
			$this->response->setJsonContent($result);
		}

		$this->response->send();
	}

    public function forgotAction()
    {
    	$email = $this->request->get('email', ['email', 'trim'], '');
		
		$user = new User();
		$result = $user->forgotPassword($email);
		$this->response->setJsonContent([
			'code' => $result[0],
			'message' => $result[1],
			'data' => new \stdClass()
		]);
		
		if ($result[0] === 200) {
			$this->utility->sendMail(
				$email, 
				'Reset Password', 
				'forgot', 
				['password' => $result[2]]
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
    	$deviceToken = isset($this->requestOAuth->request['device_token']) ? $this->requestOAuth->request['device_token'] : '';
    	if (empty($deviceToken)) {
    		$this->requestOAuth->request['device_token'] = $deviceToken;
    	}
    	$result = $this->oauth2->handleRevokeRequest($this->requestOAuth);
    	
    	if ($result->getStatusCode() === 200) {
			$this->response->setJsonContent([
				'code' => 200,
				'message' => 'Logout success',
				'data' => new \stdClass()
			]);
		} else {
			$msg = $result->getStatusText();
			if ($result->getStatusCode() === 401) {
				$msg = $result->getParameter('error_description');
			}

			$this->response->setJsonContent([
				'code' => 204,
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

    	$oldPassword = isset($this->requestOAuth->request['old_password']) ? $this->requestOAuth->request['old_password'] : '';
    	$newPassword = isset($this->requestOAuth->request['new_password']) ? $this->requestOAuth->request['new_password'] : '';
    	$param['old_password'] = $this->filter->sanitize($oldPassword, ['trim', 'striptags', 'alphanum'], '');
    	$param['new_password'] = $this->filter->sanitize($newPassword, ['trim', 'striptags', 'alphanum'], '');
    	
		$user = new User();
		$row = $user->changePassword($param);
		
		$this->response->setJsonContent([
			'code' => $row[0],
			'message' => $row[1],
			'data' => new \stdClass()
		]);

		$this->response->send();
    }
}
