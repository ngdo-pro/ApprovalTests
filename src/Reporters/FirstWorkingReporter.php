<?php

namespace ApprovalTests\Reporters;

class FirstWorkingReporter implements Reporter
{
    /**
     * @var Reporter[]
     */
    private $reporters;

    /**
     * @param Reporter[] $reporters
     */
    public function __construct(array $reporters)
    {
        $this->reporters = $reporters;
    }

    public function report($approvedFilename, $receivedFilename)
    {
        foreach ($this->reporters as $reporter) {
            if ($reporter->isWorkingInThisEnvironment($receivedFilename)) {
                $reporter->report($approvedFilename, $receivedFilename);
                return;
            }
        }
    }

    public function isWorkingInThisEnvironment($receivedFilename)
    {
        foreach ($this->reporters as $reporter) {
            if ($reporter->isWorkingInThisEnvironment($receivedFilename)) {
                return true;
            }
        }
        return false;
    }
}