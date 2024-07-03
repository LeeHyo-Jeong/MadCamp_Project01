# madcamp_project01. Spectrum

## 프로젝트 소개

Spectrum은 연락처, 갤러리, 날씨 정보 등 휴대전화에서 우리가 흔히 사용하는 세 가지 앱을 하나의 앱에 담은 올인원 앱입니다.

Spectrum은 연락처, 갤러리, 날씨 탭으로 이루어져 있습니다.

세 가지 앱을 하나의 앱에서 써보세요!

**개발환경**: Android Studio, Flutter, Figma

## 팀원 소개

- 김원중(KAIST 전산학부 20): [github 프로필](https://github.com/wjhjkim)

- 이효정(한양대학교 컴퓨터소프트웨어학부 22): [github 프로필](https://github.com/LeeHyo-Jeong)

## 프로젝트 구조

이 앱은 세 개의 탭으로 구성됩니다:

### 1. Contacts Tab
   
   - 휴대전화에 저장되어 있는 연락처 목록을 보여줍니다.
     
   - 연락처를 추가하거나 수정, 삭제할 수 있습니다.
     
   - 사용된 라이브러리 및 사용자 권한
     
       - 라이브러리: svg.dart, contacts_service.dart, permission_handler.dart, draggable_scrollbar.dart
         
       - 권한: READ_CONTACTS, WRITE_CONTACTS, READ_EXTERNAL_STORAGE
         
### 2. Gallery Tab
   
    - 휴대전화에 저장되어 있는 사진 목록을 보여줍니다.
      
    - 사진을 촬영하거나 삭제할 수 있습니다.
      
    - 사용된 라이브러리 및 사용자 권한
      
        - 라이브러리: svg.dart, photo_manager.dart, image_picker.dart, draggable_scrollbar.dart
          
        - 권한: WRITE_EXTERNAL_STORAGE, READ_EXTERNAL_STORAGE, CAMERA, android.hardware.camera, ACCESS_MEDIA_LOCATION
          
### 3. Weather Tab
   
    - 현재 GPS 위치 상의 날씨를 보여줍니다.
      
    - openWeatherMap의 날씨 정보를 가져옵니다.
      
    - 사용된 라이브러리 및 사용자 권한
      
        - 라이브러리: http.dart, cached_network_image.dart, geolocator.dart, intl.dart, timer_builder.dart, flutter_dotenv.dart
          
        - 권한: ACCESS_FINE_LOCATION, ACCESS_COARSE_LOCATION

## 페이지별 기능 설명

### 1. Loading Page

   <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/c7582158-6eee-4aae-8f68-a14e75c0a67f" width="200" height="400"/>

   - Spectrum 앱이 실행될 때 로딩 화면이 3초간 실행됩니다. 이후 자동으로 Tab page로 이동합니다.
     
### 2. Contacts Tab

   <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/9a5e7c23-5b45-4f20-bef8-05df8982c0c9" width="200" height="400"/>
   
   - Contacts 탭은 핸드폰 안에 있는 연락처 목록을 가져와서 보여줍니다.

   1. 사용자는 화면을 스크롤해 연락처 목록을 확인할 수 있습니다.
      
   2. 사용자는 화면 위의 검색창을 클릭해 원하는 이름을 검색할 수 있습니다. 초성 검색도 지원합니다.

      <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/6deed905-c59a-4b97-8a46-27b057b3b7c6" width="200" height="400"/> <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/b025f93b-f9aa-4dbb-ba6d-ad6bf9226ac5" width="200" height="400"/>
      
   4. 사용자는 연락처를 눌러 연락처의 세부정보를 확인하고 삭제할 수 있습니다.

      <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/377a7076-b9d7-4fae-8d3a-d996e30238a9" width="200" height="400"/>
      
         1. 사용자는 전화 아이콘을 클릭해 연락처의 번호에 전화를 걸 수 있습니다.
     
         2. 사용자는 문자 아이콘을 클릭해 연락처의 번호에 문자를 보낼 수 있습니다.
     
         3. 사용자는 수정 아이콘을 클릭해 프로필 사진, 이름, 전화번호, 메일을 수정할 수 있습니다.

            <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/d1869b98-60c8-4da1-83c4-5dacb639ea62" width="200" height="400"/> <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/4babe936-d4b4-486e-ac58-0082b81438a6" width="200" height="400"/>
      
   5. 사용자는 오른쪽 아래의 + 버튼을 클릭해 새 연락처를 추가할 수 있습니다

      <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/8b7a41c5-feda-4afd-b243-b2bf69f3626a" width="200" height="400"/> <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/9fb8c3f2-096f-43cd-82c4-51d6b5e3933e" width="200" height="400"/>

      
### 3. Gallery Tab

   <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/bb89f7d9-0ced-4153-b909-e402dc1e8237" width="200" height="400"/>
   
   - Gallery 탭은 핸드폰 내에 있는 이미지들을 가져와서 보여줍니다.
   
   1. 사용자는 화면을 스크롤해 이미지 목록을 확인할 수 있습니다.
      
   2. 사용자는 이미지를 클릭해 이미지를 자세히 볼 수 있습니다.

      <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/25c38451-d3a9-4c46-954b-c46d9eb1f2f0" width="200" height="400"/>

      1. 사용자는 이미지를 스와이프해 다른 이미지 페이지로 이동할 수 있습니다.
     
      2. 사용자는 확대 제스처를 통해 이미지를 확대/축소할 수 있습니다.

            <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/89968c2c-8ae6-40b7-855f-033a10045e86" width="200" height="400"/>

      3. 사용자는 오른쪽 위의 세부정보 버튼을 눌러 이미지의 이름, 생성 날짜, 크기 정보를 확인할 수 있습니다.

            <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/897d702b-de1e-4351-ab62-5d3ad35a5d0a" width="200" height="400"/>
      
      4. 사용자는 오른쪽 위의 삭제 버튼을 눌러 이미지를 삭제할 수 있습니다.

            <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/c045dd7a-84e8-4ee3-ac1e-6f5084a3c228" width="200" height="400"/>
     
      5. 사용자는 새로운 사진을 찍어서 갤러리에 추가할 수 있습니다.

            <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/8bfdddf2-3f04-45ef-a77d-e627ce754ce2" width="200" height="400"/> <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/79061ab4-5abe-4582-a197-a50fff176bd3" width="200" height="400"/>

### 4. Weather Tab

   <img src="https://github.com/LeeHyo-Jeong/MadCamp_Project01/assets/96229091/b697c00a-3a34-4310-8872-b7084b57bb4c" width="200" height="400"/>
   
   - Forecast 탭은 핸드폰의 GPS를 통해 사용자가 위치한 지역의 날씨 정보를 보여줍니다.
   
   1. 사용자는 새로고침 버튼을 클릭해 날씨 정보를 갱신할 수 있습니다.

## APK 파일
- [링크](https://drive.google.com/file/d/1tvJFlmBXO0vkiTiHib-6w0VSDc1PObH3/view?usp=sharing)
