package chuchu.runnerway.member.exception;

import static chuchu.runnerway.member.domain.ExceptionMessages.NOT_FOUND;

public class NotFoundMemberException extends RuntimeException {

    public NotFoundMemberException() {
        super(NOT_FOUND.getMessage());
    }
}
