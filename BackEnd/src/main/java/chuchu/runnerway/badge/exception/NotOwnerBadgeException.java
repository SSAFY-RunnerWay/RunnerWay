package chuchu.runnerway.badge.exception;

import static chuchu.runnerway.badge.domain.ExceptionMessages.NOT_OWNER;

public class NotOwnerBadgeException extends RuntimeException {

    public NotOwnerBadgeException() {
        super(NOT_OWNER.getMessage());
    }
}
