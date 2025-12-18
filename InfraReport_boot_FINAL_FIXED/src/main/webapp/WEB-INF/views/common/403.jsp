<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>접근 거부 - 403</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            color: white;
        }
        .error-code {
            font-size: 8rem;
            font-weight: 700;
            text-shadow: 3px 3px 10px rgba(0,0,0,0.2);
        }
        .error-icon {
            font-size: 5rem;
            margin-bottom: 20px;
            animation: shake 0.5s ease-in-out infinite alternate;
        }
        @keyframes shake {
            from { transform: rotate(-5deg); }
            to { transform: rotate(5deg); }
        }
        .btn-home {
            background: white;
            color: #667eea;
            border: none;
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: transform 0.3s;
        }
        .btn-home:hover {
            transform: scale(1.05);
            color: #764ba2;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-ban"></i>
        </div>
        <div class="error-code">403</div>
        <h2 class="mb-3">접근이 거부되었습니다</h2>
        <p class="mb-4 opacity-75">이 페이지에 접근할 권한이 없습니다.</p>
        <a href="/" class="btn btn-home">
            <i class="fas fa-home me-2"></i>홈으로 돌아가기
        </a>
    </div>
</body>
</html>
