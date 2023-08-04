<?php namespace ApprovalTests\Tests;

use PHPUnit\Framework\TestCase;

class ErrorHandlerTest extends TestCase
{
    public function testEWarning()
    {
        $this->setExpectedException(\ErrorException::class);
        trigger_error('Demo warning', E_USER_WARNING);
    }
}