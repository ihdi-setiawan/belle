<?php

namespace App\Library;

class Utility extends \Phalcon\Mvc\User\Component
{
    protected $transport;

    /**
     * Applies a template to be used in the e-mail
     *
     * @param string $name
     * @param array $params
     */
    private function getEmailTemplate($name, $params)
    {
        $parameters = array_merge(array(
            'password' => $params['password'],
        ), $params);
        return $this->view->getRender('email', $name, $parameters, function($view){
            $view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_LAYOUT);
        });
        return $view->getContent();
    }

    /**
     * Sends e-mails via gmail based on predefined templates
     *
     * @param array $to
     * @param string $subject
     * @param string $name
     * @param array $params
     */
    public function sendMail($to, $subject, $name, $params = array())
    {
        $mailSettings = $this->config->mail;
        $template = $this->getEmailTemplate($name, $params);
        
        //create message
        $message = \Swift_Message::newInstance()
            ->setSubject($subject)
            ->setFrom([
                $mailSettings->fromEmail => $mailSettings->fromName
            ])
            ->setTo($to)
            ->setBody($template, 'text/html');
        if (!isset($this->transport)) {
            $this->transport = \Swift_SmtpTransport::newInstance(
                $mailSettings->smtp->server,
                $mailSettings->smtp->port,
                $mailSettings->smtp->security
            )
            ->setUsername($mailSettings->smtp->username)
            ->setPassword($mailSettings->smtp->password);
        }

        $mailer = \Swift_Mailer::newInstance($this->transport);
        return $mailer->send($message);
    }
}