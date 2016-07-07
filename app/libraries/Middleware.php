<?php

namespace App\Libraries;

class Middleware extends \Phalcon\Mvc\User\Plugin implements \Sid\Phalcon\AuthMiddleware\MiddlewareInterface
{
    public $isLoggedIn = false;
    public $clientId = null;
    public $userId = null;
    public $expires = null;

	/**
     * @return boolean
     */
    public function authenticate()
    {
        $msg = '';
        $token = $this->request->get('token', ['trim', 'alphanum'], '');
        if (empty($token)) {
            $msg = 'Missing mandatory parameter';
        } else {
            $response = $this->oauth2->getAccessTokenData($this->requestOAuth, new \OAuth2\Response());
            if ($response) {
                $this->registry[$token] = [
                    'user_id' => $response['user_id'],
                    'client_id' => $response['client_id'],
                    'expires' => $response['expires']
                ];
                
                return true;
            } else {
                $msg = 'Unauthorized access';
            }
        }

        $this->dispatcher->forward([
            'controller' => 'base',
            'action' => 'showError',
            'params' => ['msg' => $msg]
        ]);

        return false;
    }
}