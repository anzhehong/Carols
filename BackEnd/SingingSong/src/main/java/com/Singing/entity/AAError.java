package com.Singing.entity;

/**
 * Created by fowafolo
 * Date: 16/5/12
 * Time: 21:33
 */
public class AAError {

    static public String defaultDomain = "edu.tac.carols";
    static public int defaultCode = 999;

    private String domain;
    private int code;
    private String message;

    public AAError(String message) {
        this.message = message;
        this.code = AAError.defaultCode;
        this.domain = AAError.defaultDomain;
    }

    public AAError(String message, int code) {
        this.message = message;
        this.code = code;
        this.domain = AAError.defaultDomain;
    }

    public AAError(String domain, int code, String message) {
        this.domain = domain;
        this.code = code;
        this.message = message;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
