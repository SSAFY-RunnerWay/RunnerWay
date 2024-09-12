package chuchu.runnerway.badge.exception;

import static chuchu.runnerway.badge.domain.ExceptionMessages.NOT_FOUND;

public class NotFoundBadgeException extends RuntimeException {

    public NotFoundBadgeException() {
        super(NOT_FOUND.getMessage());
    }
}
