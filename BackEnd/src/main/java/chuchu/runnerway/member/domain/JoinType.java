package chuchu.runnerway.member.domain;

public enum JoinType {
    kakao("kakao");

    private final String type;

    JoinType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }
}
