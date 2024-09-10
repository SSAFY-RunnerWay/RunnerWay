package chuchu.runnerway.member.exception;


import static chuchu.runnerway.member.domain.ExceptionMessages.DUPLICATE;

public class MemberDuplicateException extends RuntimeException {

    public MemberDuplicateException() {
        super(DUPLICATE.getMessage());
    }
}
