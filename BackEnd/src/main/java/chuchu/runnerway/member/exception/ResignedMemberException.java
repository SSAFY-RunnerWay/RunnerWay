package chuchu.runnerway.member.exception;

import static chuchu.runnerway.member.domain.ExceptionMessages.RESIGNED;

public class ResignedMemberException extends RuntimeException {

    public ResignedMemberException() {
        super(RESIGNED.getMessage());
    }
}
