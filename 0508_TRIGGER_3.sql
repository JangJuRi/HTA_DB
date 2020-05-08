-- 책에 대한 리뷰가 작성될 때마다 책 번호에 해당 평점을 변경하는 TRIGGER
CREATE OR REPLACE TRIGGER UPDATE_REVIEW_POINT_TRIGGER
    BEFORE
    INSERT OR UPDATE ON SAMPLE_BOOK_REVIEWS
    FOR EACH ROW
    
    DECLARE
        v_current_point     number(2,1);
        v_current_row_count number;
        v_temp_point        number;
        v_point             number(2,1);
    BEGIN
        SELECT BOOK_POINT INTO v_current_point
        FROM SAMPLE_BOOKS
        WHERE BOOK_NO = :NEW.BOOK_NO;
        
        SELECT COUNT(*) INTO v_current_row_count
        FROM SAMPLE_BOOK_REVIEWS
        WHERE BOOK_NO = :NEW.BOOK_NO;
    
        v_temp_point := (v_current_point * v_current_row_count + :NEW.REVIEW_POINT) / (v_current_row_count + 1);
        v_point := trunc(v_temp_point, 1);
        
        UPDATE SAMPLE_BOOKS
        SET
            BOOK_POINT = v_point
        WHERE
            BOOK_NO = :NEW.BOOK_NO;
    END;