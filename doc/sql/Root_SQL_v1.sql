-- 유저
DROP TABLE IF EXISTS `users` RESTRICT;

-- 포인트내역
DROP TABLE IF EXISTS `points` RESTRICT;

-- 코스
DROP TABLE IF EXISTS `courses` RESTRICT;

-- 리뷰
DROP TABLE IF EXISTS `reviews` RESTRICT;

-- 인포
DROP TABLE IF EXISTS `infos` RESTRICT;

-- 장소
DROP TABLE IF EXISTS `course_places` RESTRICT;

-- 데이
DROP TABLE IF EXISTS `course_days` RESTRICT;

-- 데이리뷰
DROP TABLE IF EXISTS `review_days` RESTRICT;

-- 장소리뷰
DROP TABLE IF EXISTS `review_place` RESTRICT;

-- 유저장소스크랩
DROP TABLE IF EXISTS `place_scraps` RESTRICT;

-- 유저데이스크랩
DROP TABLE IF EXISTS `day_scraps` RESTRICT;

-- 유저
CREATE TABLE `users` (
  `user_no`        INTEGER      NOT NULL COMMENT '유저번호', -- 유저번호
  `user_name`      VARCHAR(30)  NOT NULL COMMENT '이름', -- 이름
  `birthday`       DATE         NOT NULL COMMENT '생년월일', -- 생년월일
  `gender`         INTEGER      NOT NULL COMMENT '성별', -- 성별
  `email`          VARCHAR(50)  NOT NULL COMMENT '이메일', -- 이메일
  `password`       VARCHAR(255) NOT NULL COMMENT '비밀번호', -- 비밀번호
  `phone_number`   VARCHAR(50)  NOT NULL COMMENT '핸드폰번호', -- 핸드폰번호
  `zip_code`       INTEGER(6)   NOT NULL COMMENT '우편번호', -- 우편번호
  `basic_address`  VARCHAR(50)  NOT NULL COMMENT '기본주소', -- 기본주소
  `detail_address` VARCHAR(50)  NULL     COMMENT '상세주소', -- 상세주소
  `photo`          VARCHAR(255) NULL     COMMENT '사진', -- 사진
  `nickname`       VARCHAR(30)  NOT NULL COMMENT '별명', -- 별명
  `account`        INTEGER(30)  NULL     COMMENT '계좌번호', -- 계좌번호
  `bank`           VARCHAR(30)  NULL     COMMENT '은행' -- 은행
)
COMMENT '유저';

-- 유저
ALTER TABLE `users`
  ADD CONSTRAINT `PK_users` -- 유저 기본키
    PRIMARY KEY (
      `user_no` -- 유저번호
    );

ALTER TABLE `users`
  MODIFY COLUMN `user_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '유저번호';

-- 포인트내역
CREATE TABLE `points` (
  `point_no`    INTEGER  NOT NULL COMMENT '포인트내역번호', -- 포인트내역번호
  `user_no`     INTEGER  NOT NULL COMMENT '소유주번호', -- 소유주번호
  `trader_no`   INTEGER  NULL     COMMENT '상대편번호', -- 상대편번호
  `point_type`  INTEGER  NOT NULL COMMENT '입출금', -- 입출금
  `content`     INTEGER  NOT NULL COMMENT '입출금내용', -- 입출금내용
  `price`       INTEGER  NOT NULL COMMENT '금액', -- 금액
  `create_date` DATETIME NULL     DEFAULT now() COMMENT '거래일' -- 거래일
)
COMMENT '포인트내역';

-- 포인트내역
ALTER TABLE `points`
  ADD CONSTRAINT `PK_points` -- 포인트내역 기본키
    PRIMARY KEY (
      `point_no` -- 포인트내역번호
    );

ALTER TABLE `points`
  MODIFY COLUMN `point_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '포인트내역번호';

-- 코스
CREATE TABLE `courses` (
  `course_no`   INTEGER  NOT NULL COMMENT '코스번호', -- 코스번호
  `user_no`     INTEGER  NOT NULL COMMENT '유저번호', -- 유저번호
  `create_date` DATETIME NULL     DEFAULT now() COMMENT '생성일' -- 생성일
)
COMMENT '코스';

-- 코스
ALTER TABLE `courses`
  ADD CONSTRAINT `PK_courses` -- 코스 기본키
    PRIMARY KEY (
      `course_no` -- 코스번호
    );

ALTER TABLE `courses`
  MODIFY COLUMN `course_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '코스번호';

-- 리뷰
CREATE TABLE `reviews` (
  `review_no`   INTEGER  NOT NULL COMMENT '리뷰번호', -- 리뷰번호
  `user_no`     INTEGER  NOT NULL COMMENT '유저번호', -- 유저번호
  `create_date` DATETIME NULL     DEFAULT now() COMMENT '작성일자', -- 작성일자
  `status`      INTEGER  NOT NULL COMMENT '작성상태' -- 작성상태
)
COMMENT '리뷰';

-- 리뷰
ALTER TABLE `reviews`
  ADD CONSTRAINT `PK_reviews` -- 리뷰 기본키
    PRIMARY KEY (
      `review_no` -- 리뷰번호
    );

ALTER TABLE `reviews`
  MODIFY COLUMN `review_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '리뷰번호';

-- 인포
CREATE TABLE `infos` (
  `info_no`     INTEGER     NOT NULL COMMENT '인포번호', -- 인포번호
  `create_date` DATETIME    NULL     COMMENT '작성일', -- 작성일
  `category`    INTEGER     NOT NULL COMMENT '카테고리', -- 카테고리
  `title`       VARCHAR(50) NOT NULL COMMENT '제목', -- 제목
  `content`     TEXT        NOT NULL COMMENT '내용' -- 내용
)
COMMENT '인포';

-- 인포
ALTER TABLE `infos`
  ADD CONSTRAINT `PK_infos` -- 인포 기본키
    PRIMARY KEY (
      `info_no` -- 인포번호
    );

ALTER TABLE `infos`
  MODIFY COLUMN `info_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '인포번호';

-- 장소
CREATE TABLE `course_places` (
  `place_no`             INTEGER     NOT NULL COMMENT '장소번호', -- 장소번호
  `course_day_no`        INTEGER     NOT NULL COMMENT '데이번호', -- 데이번호
  `place_name`           VARCHAR(30) NOT NULL COMMENT '장소명', -- 장소명
  `place_basic_address`  VARCHAR(50) NOT NULL COMMENT '기본주소', -- 기본주소
  `place_detail_address` VARCHAR(50) NULL     COMMENT '상세주소', -- 상세주소
  `etc`                  TEXT        NULL     COMMENT '비고' -- 비고
)
COMMENT '장소';

-- 장소
ALTER TABLE `course_places`
  ADD CONSTRAINT `PK_course_places` -- 장소 기본키
    PRIMARY KEY (
      `place_no` -- 장소번호
    );

ALTER TABLE `course_places`
  MODIFY COLUMN `place_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '장소번호';

-- 데이
CREATE TABLE `course_days` (
  `course_day_no` INTEGER     NOT NULL COMMENT '데이번호', -- 데이번호
  `course_no`     INTEGER     NOT NULL COMMENT '코스번호', -- 코스번호
  `title`         VARCHAR(50) NOT NULL COMMENT '제목', -- 제목
  `day_date`      DATE        NOT NULL COMMENT '일자' -- 일자
)
COMMENT '데이';

-- 데이
ALTER TABLE `course_days`
  ADD CONSTRAINT `PK_course_days` -- 데이 기본키
    PRIMARY KEY (
      `course_day_no` -- 데이번호
    );

ALTER TABLE `course_days`
  MODIFY COLUMN `course_day_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '데이번호';

-- 데이리뷰
CREATE TABLE `review_days` (
  `review_day_no` INTEGER      NOT NULL COMMENT '데이리뷰번호', -- 데이리뷰번호
  `main_photo`    VARCHAR(255) NOT NULL COMMENT '대표사진', -- 대표사진
  `title`         VARCHAR(50)  NOT NULL COMMENT '데이제목', -- 데이제목
  `day_date`      DATE         NOT NULL COMMENT '데이일자', -- 데이일자
  `day_review`    TEXT         NOT NULL COMMENT '데이후기', -- 데이후기
  `status`        INTEGER      NOT NULL COMMENT '작성상태', -- 작성상태
  `review_no`     INTEGER      NOT NULL COMMENT '리뷰번호' -- 리뷰번호
)
COMMENT '데이리뷰';

-- 데이리뷰
ALTER TABLE `review_days`
  ADD CONSTRAINT `PK_review_days` -- 데이리뷰 기본키
    PRIMARY KEY (
      `review_day_no` -- 데이리뷰번호
    );

ALTER TABLE `review_days`
  MODIFY COLUMN `review_day_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '데이리뷰번호';

-- 장소리뷰
CREATE TABLE `review_place` (
  `review_place_no`      INTEGER      NOT NULL COMMENT '장소리뷰번호', -- 장소리뷰번호
  `place_name`           VARCHAR(30)  NOT NULL COMMENT '장소명', -- 장소명
  `place_basic_address`  VARCHAR(50)  NOT NULL COMMENT '기본주소', -- 기본주소
  `place_detail_address` VARCHAR(50)  NULL     COMMENT '상세주소', -- 상세주소
  `place_review`         TEXT         NOT NULL COMMENT '장소후기', -- 장소후기
  `main_photo`           VARCHAR(255) NOT NULL COMMENT '대표사진', -- 대표사진
  `status`               INTEGER      NOT NULL COMMENT '작성상태', -- 작성상태
  `review_day_no`        INTEGER      NOT NULL COMMENT '데이리뷰번호' -- 데이리뷰번호
)
COMMENT '장소리뷰';

-- 장소리뷰
ALTER TABLE `review_place`
  ADD CONSTRAINT `PK_review_place` -- 장소리뷰 기본키
    PRIMARY KEY (
      `review_place_no` -- 장소리뷰번호
    );

ALTER TABLE `review_place`
  MODIFY COLUMN `review_place_no` INTEGER NOT NULL AUTO_INCREMENT COMMENT '장소리뷰번호';

-- 유저장소스크랩
CREATE TABLE `place_scraps` (
  `user_no`         INTEGER NOT NULL COMMENT '유저번호', -- 유저번호
  `review_place_no` INTEGER NOT NULL COMMENT '장소리뷰번호' -- 장소리뷰번호
)
COMMENT '유저장소스크랩';

-- 유저장소스크랩
ALTER TABLE `place_scraps`
  ADD CONSTRAINT `PK_place_scraps` -- 유저장소스크랩 기본키
    PRIMARY KEY (
      `user_no`,         -- 유저번호
      `review_place_no`  -- 장소리뷰번호
    );

-- 유저데이스크랩
CREATE TABLE `day_scraps` (
  `user_no`       INTEGER NOT NULL COMMENT '유저번호', -- 유저번호
  `review_day_no` INTEGER NOT NULL COMMENT '데이리뷰번호' -- 데이리뷰번호
)
COMMENT '유저데이스크랩';

-- 유저데이스크랩
ALTER TABLE `day_scraps`
  ADD CONSTRAINT `PK_day_scraps` -- 유저데이스크랩 기본키
    PRIMARY KEY (
      `user_no`,       -- 유저번호
      `review_day_no`  -- 데이리뷰번호
    );

-- 포인트내역
ALTER TABLE `points`
  ADD CONSTRAINT `FK_users_TO_points` -- 유저 -> 포인트내역
    FOREIGN KEY (
      `user_no` -- 소유주번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 포인트내역
ALTER TABLE `points`
  ADD CONSTRAINT `FK_users_TO_points2` -- 유저 -> 포인트내역2
    FOREIGN KEY (
      `trader_no` -- 상대편번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 코스
ALTER TABLE `courses`
  ADD CONSTRAINT `FK_users_TO_courses` -- 유저 -> 코스
    FOREIGN KEY (
      `user_no` -- 유저번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 리뷰
ALTER TABLE `reviews`
  ADD CONSTRAINT `FK_users_TO_reviews` -- 유저 -> 리뷰
    FOREIGN KEY (
      `user_no` -- 유저번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 장소
ALTER TABLE `course_places`
  ADD CONSTRAINT `FK_course_days_TO_course_places` -- 데이 -> 장소
    FOREIGN KEY (
      `course_day_no` -- 데이번호
    )
    REFERENCES `course_days` ( -- 데이
      `course_day_no` -- 데이번호
    );

-- 데이
ALTER TABLE `course_days`
  ADD CONSTRAINT `FK_courses_TO_course_days` -- 코스 -> 데이
    FOREIGN KEY (
      `course_no` -- 코스번호
    )
    REFERENCES `courses` ( -- 코스
      `course_no` -- 코스번호
    );

-- 데이리뷰
ALTER TABLE `review_days`
  ADD CONSTRAINT `FK_reviews_TO_review_days` -- 리뷰 -> 데이리뷰
    FOREIGN KEY (
      `review_no` -- 리뷰번호
    )
    REFERENCES `reviews` ( -- 리뷰
      `review_no` -- 리뷰번호
    );

-- 장소리뷰
ALTER TABLE `review_place`
  ADD CONSTRAINT `FK_review_days_TO_review_place` -- 데이리뷰 -> 장소리뷰
    FOREIGN KEY (
      `review_day_no` -- 데이리뷰번호
    )
    REFERENCES `review_days` ( -- 데이리뷰
      `review_day_no` -- 데이리뷰번호
    );

-- 유저장소스크랩
ALTER TABLE `place_scraps`
  ADD CONSTRAINT `FK_users_TO_place_scraps` -- 유저 -> 유저장소스크랩
    FOREIGN KEY (
      `user_no` -- 유저번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 유저장소스크랩
ALTER TABLE `place_scraps`
  ADD CONSTRAINT `FK_review_place_TO_place_scraps` -- 장소리뷰 -> 유저장소스크랩
    FOREIGN KEY (
      `review_place_no` -- 장소리뷰번호
    )
    REFERENCES `review_place` ( -- 장소리뷰
      `review_place_no` -- 장소리뷰번호
    );

-- 유저데이스크랩
ALTER TABLE `day_scraps`
  ADD CONSTRAINT `FK_users_TO_day_scraps` -- 유저 -> 유저데이스크랩
    FOREIGN KEY (
      `user_no` -- 유저번호
    )
    REFERENCES `users` ( -- 유저
      `user_no` -- 유저번호
    );

-- 유저데이스크랩
ALTER TABLE `day_scraps`
  ADD CONSTRAINT `FK_review_days_TO_day_scraps` -- 데이리뷰 -> 유저데이스크랩
    FOREIGN KEY (
      `review_day_no` -- 데이리뷰번호
    )
    REFERENCES `review_days` ( -- 데이리뷰
      `review_day_no` -- 데이리뷰번호
    );