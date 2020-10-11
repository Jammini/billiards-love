/* 카카오 로그인 목록 */
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141501, NOW(), '안정용', 'https://picsum.photos/640', 'https://picsum.photos/110');
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141502, NOW(), '김형익', 'https://picsum.photos/640', 'https://picsum.photos/110');
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141503, NOW(), '김정민', 'https://picsum.photos/640', 'https://picsum.photos/110');
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141504, NOW(), '최인석', 'https://picsum.photos/640', 'https://picsum.photos/110');
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141505, NOW(), '나지수', 'https://picsum.photos/640', 'https://picsum.photos/110');
INSERT INTO TBL_KKO_LGN (LGN_ID, LST_CNCT_DT, NCK_NM, PRFL_IMG_URL, PRFL_THMB_IMG_URL)
VALUES (1213141506, NOW(), '여규리', 'https://picsum.photos/640', 'https://picsum.photos/110');
/* 회원 목록 */
ALTER TABLE TBL_MMBR
    ALTER COLUMN MMBR_ID BIGINT AUTO_INCREMENT (7);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (1, '안탑', 22, NOW(), 1213141501);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (2, '띠용', 20, NOW(), 1213141502);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (3, '잼미니', 25, NOW(), 1213141503);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (4, '인디', 21, NOW(), 1213141504);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (5, '나지수', 30, NOW(), 1213141505);
INSERT INTO TBL_MMBR (MMBR_ID, MMBR_NCK_NM, MMBR_HNDC, RGST_DT, KKO_LGN_ID)
VALUES (6, '귤귤', 27, NOW(), 1213141506);
/* 관리자 목록 */
ALTER TABLE TBL_MNGR
    ALTER COLUMN MNGR_ID BIGINT AUTO_INCREMENT (2);
INSERT INTO TBL_MNGR (MNGR_ID, LGN_ID, LGN_BOX)
VALUES (1, 'admin', /* P@ssw0rd */ '{bcrypt}$2a$10$jSf5NBDRkzz9/IKc2GIjiOTynz/.5cMEt1wiSK0wYpn24ntqlKUBS');
/** 2019 대회 - 종료 (CNTS_ID = 1) */
ALTER TABLE TBL_CNTS
    ALTER COLUMN CNTS_ID BIGINT AUTO_INCREMENT (4);
INSERT INTO TBL_CNTS (CNTS_ID, CNTS_NM, CNTS_DSCR, STRT_DATE, STRT_TIME, END_DATE, END_TIME, PRGR_STT, MAX_PRTC_PRSN,
                      RGST_MNGR_ID, RGST_DT)
VALUES (1, '2019 리그전', '2020.01.01~', PARSEDATETIME('20190101', 'yyyyMMdd'), PARSEDATETIME('000000', 'HHmmss'),
        PARSEDATETIME('20191230', 'yyyyMMdd'), PARSEDATETIME('235959', 'HHmmss'), '2', 64,
        (SELECT MNGR_ID FROM TBL_MNGR where LGN_ID = 'admin'), PARSEDATETIME('20181006124401', 'yyyyMMddHHmmss'));
/* 참가자 4명 */
ALTER TABLE TBL_MNGR
    ALTER COLUMN MNGR_ID BIGINT AUTO_INCREMENT (5);
INSERT INTO TBL_PLYR (PLYR_ID, CNTS_ID, MMBR_ID, PLYR_NO, PRTC_HNDC, PLYR_RNKN, PLYR_SCR)
VALUES (1, 1, 1, 1, 22, 1, 0);
INSERT INTO TBL_PLYR (PLYR_ID, CNTS_ID, MMBR_ID, PLYR_NO, PRTC_HNDC, PLYR_RNKN, PLYR_SCR)
VALUES (2, 1, 2, 2, 24, 1, 0);
INSERT INTO TBL_PLYR (PLYR_ID, CNTS_ID, MMBR_ID, PLYR_NO, PRTC_HNDC, PLYR_RNKN, PLYR_SCR)
VALUES (3, 1, 3, 3, 26, 1, 0);
INSERT INTO TBL_PLYR (PLYR_ID, CNTS_ID, MMBR_ID, PLYR_NO, PRTC_HNDC, PLYR_RNKN, PLYR_SCR)
VALUES (4, 1, 4, 4, 28, 1, 0);
/** 결기 결과 입력 */
ALTER TABLE TBL_GAME_RSLT_INPT
    ALTER COLUMN GAME_RSLT_INPT_ID BIGINT AUTO_INCREMENT (5);
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (1, 1, 2, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (2, 1, 3, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (3, 1, 4, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (4, 2, 1, 2, 2, 2, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (5, 2, 3, 1, 2, 2, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (6, 2, 4, 1, 1, 2, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (7, 3, 1, 2, 2, 2, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (8, 3, 2, 2, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (9, 3, 4, 2, 2, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (10, 4, 1, 2, 2, 2, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (11, 4, 2, 2, 2, 1, NOW());
INSERT INTO TBL_GAME_RSLT_INPT (GAME_RSLT_INPT_ID, PLYR_ID, OPNN_PLYR_ID, FRST_RSLT, SCND_RSLT, THRD_RSLT, INPT_DT)
VALUES (12, 4, 3, 1, 1, 2, NOW());
/** 경기 확정 결과 */
ALTER TABLE TBL_GAME_RSLT_CNFR
    ALTER COLUMN GAME_RSLT_CNFR_ID BIGINT AUTO_INCREMENT (7);
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (1, 1, 1, 2, 4, 1, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (2, 1, 2, 3, 7, 1, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (3, 1, 3, 4, 10, 1, 1, 1, 1, NOW());
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (4, 2, 5, 3, 8, 1, 2, 2, 1, NOW());
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (5, 2, 6, 4, 11, 1, 1, 2, 1, NOW());
INSERT INTO TBL_GAME_RSLT_CNFR (GAME_RSLT_CNFR_ID, PLYR_ID, PLYR_INPT_ID, OPNN_PLYR_ID, OPNN_PLYR_INPT_ID, FRST_RSLT,
                                SCND_RSLT, THRD_RSLT, CNFR_MNGR_ID, CNFR_DT)
VALUES (6, 3, 9, 4, 12, 2, 2, 1, 1, NOW());

/** 2020 대회 - 진행중 (CNTS_ID = 2) */
INSERT INTO TBL_CNTS (CNTS_ID, CNTS_NM, CNTS_DSCR, STRT_DATE, STRT_TIME, END_DATE, END_TIME, PRGR_STT, MAX_PRTC_PRSN,
                      RGST_MNGR_ID, RGST_DT)
VALUES (2, '2020 리그전', '2020.01.01~', PARSEDATETIME('20200101', 'yyyyMMdd'), PARSEDATETIME('000000', 'HHmmss'),
        PARSEDATETIME('20201230', 'yyyyMMdd'), PARSEDATETIME('235959', 'HHmmss'), '1', 32,
        (SELECT MNGR_ID FROM TBL_MNGR where LGN_ID = 'admin'), PARSEDATETIME('20191112151145', 'yyyyMMddHHmmss'));
/* 참가자 3명 */


/** 2021 대회 - 모집중 (CNTS_ID = 3) */
INSERT INTO TBL_CNTS (CNTS_ID, CNTS_NM, CNTS_DSCR, STRT_DATE, STRT_TIME, END_DATE, END_TIME, PRGR_STT, MAX_PRTC_PRSN,
                      RGST_MNGR_ID, RGST_DT)
VALUES (3, '2021 리그전', '2021.01.01~', PARSEDATETIME('20210101', 'yyyyMMdd'), PARSEDATETIME('000000', 'HHmmss'),
        PARSEDATETIME('20211230', 'yyyyMMdd'), PARSEDATETIME('235959', 'HHmmss'), '0', 128,
        (SELECT MNGR_ID FROM TBL_MNGR where LGN_ID = 'admin'), PARSEDATETIME('20200411001145', 'yyyyMMddHHmmss'));
/* 참가자 2명 */
INSERT INTO TBL_PLYR (CNTS_ID, MMBR_ID, PRTC_HNDC)
VALUES (3, 1, 30);
INSERT INTO TBL_PLYR (CNTS_ID, MMBR_ID, PRTC_HNDC)
VALUES (3, 2, 28);


/* 공지사항 */
INSERT INTO TBL_NTC (NTC_TTL, NTC_CNTN, TRGT_CNTS_ID, RGST_MNGR_ID, RGST_DT)
VALUES ('공지사항 제목', '공지사항 내용', NULL, 1, NOW());



