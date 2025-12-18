package com.infraReport.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

/**
 * 파일 업로드 유틸리티
 */
public class FileUploadUtil {

    private FileUploadUtil() {
        // 유틸리티 클래스
    }

    /**
     * 파일 저장
     * @param file 업로드 파일
     * @param uploadPath 저장 경로
     * @param subDirectory 하위 디렉토리
     * @return 저장된 파일 경로 (상대 경로)
     */
    public static String saveFile(MultipartFile file, String uploadPath, String subDirectory)
            throws IOException {

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어있습니다.");
        }

        // 날짜별 디렉토리 생성
        String dateDir = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        String targetDir = uploadPath + "/" + subDirectory + "/" + dateDir;

        Path dirPath = Paths.get(targetDir);
        if (!Files.exists(dirPath)) {
            Files.createDirectories(dirPath);
        }

        // 고유 파일명 생성
        String originalFileName = file.getOriginalFilename();
        String extension = getExtension(originalFileName);
        String savedFileName = UUID.randomUUID().toString() + extension;

        // 파일 저장
        Path filePath = dirPath.resolve(savedFileName);
        file.transferTo(filePath.toFile());

        // 상대 경로 반환
        return subDirectory + "/" + dateDir + "/" + savedFileName;
    }

    /**
     * 파일 확장자 추출
     */
    public static String getExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf("."));
    }

    /**
     * 파일 삭제
     */
    public static boolean deleteFile(String uploadPath, String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }

        File file = new File(uploadPath + "/" + filePath);
        return file.exists() && file.delete();
    }

    /**
     * 파일 존재 확인
     */
    public static boolean exists(String uploadPath, String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }

        File file = new File(uploadPath + "/" + filePath);
        return file.exists();
    }
}
