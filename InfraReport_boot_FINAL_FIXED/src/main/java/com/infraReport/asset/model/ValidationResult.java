package com.infraReport.asset.model;

import java.util.ArrayList;
import java.util.List;

/**
 * 유효성 검증 결과
 * 
 * 사용법:
 * ValidationResult result = service.validate();
 * if (!result.isValid()) {
 *     System.out.println(result.getErrorMessage());
 * }
 */
public class ValidationResult {
    
    private List<String> errors;
    
    public ValidationResult() {
        this.errors = new ArrayList<>();
    }
    
    /**
     * 에러 추가
     */
    public void addError(String error) {
        if (error != null && !error.trim().isEmpty()) {
            errors.add(error);
        }
    }
    
    /**
     * 여러 에러 추가
     */
    public void addErrors(List<String> errors) {
        if (errors != null) {
            this.errors.addAll(errors);
        }
    }
    
    /**
     * 유효한지 확인
     */
    public boolean isValid() {
        return errors.isEmpty();
    }
    
    /**
     * 에러 목록 가져오기
     */
    public List<String> getErrors() {
        return new ArrayList<>(errors);
    }
    
    /**
     * 에러 메시지 (쉼표로 구분)
     */
    public String getErrorMessage() {
        return String.join(", ", errors);
    }
    
    /**
     * 에러 메시지 (줄바꿈으로 구분)
     */
    public String getErrorMessageWithNewLine() {
        return String.join("\n", errors);
    }
    
    /**
     * 첫 번째 에러 메시지
     */
    public String getFirstError() {
        return errors.isEmpty() ? "" : errors.get(0);
    }
    
    /**
     * 에러 개수
     */
    public int getErrorCount() {
        return errors.size();
    }
    
    /**
     * 에러 존재 여부
     */
    public boolean hasErrors() {
        return !errors.isEmpty();
    }
    
    /**
     * 에러 초기화
     */
    public void clear() {
        errors.clear();
    }
    
    @Override
    public String toString() {
        return "ValidationResult{" +
                "valid=" + isValid() +
                ", errorCount=" + getErrorCount() +
                ", errors=" + errors +
                '}';
    }
}
