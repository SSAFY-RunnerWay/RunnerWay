package chuchu.runnerway.badge.domain;

public enum ExceptionMessages {

    NOT_FOUND("해당 뱃지를 찾을 수 없습니다."),
    NOT_OWNER("해당 뱃지의 주인이 아닙니다.");

    private final String message;

    ExceptionMessages(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
