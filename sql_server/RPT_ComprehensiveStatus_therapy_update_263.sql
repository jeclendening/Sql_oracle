--------------------------------------------------


DECLARE @ProgramID INT;
DECLARE @CompanyID INT
DECLARE @TherapyId INT
DECLARE @Therapy varchar(max);

BEGIN TRAN
----------------------------
SET @ProgramID = 263;
SET @Therapy = 'Oncology';
SET @CompanyID = (
        SELECT CompanyID
        FROM PSProgram
        WHERE ProgramID = @programID
        )

SET @TherapyId = (
        SELECT TherapyId
        FROM PSTherapyArea
        WHERE CompanyId = @CompanyID
            AND Therapy = @Therapy
        );
IF @TherapyId is null
BEGIN
    INSERT INTO PSTherapyArea (
        CompanyId
        ,Therapy
        )
    VALUES (
        @CompanyID
        ,@Therapy
        );

    SET @TherapyId = (
            SELECT TherapyId
            FROM PSTherapyArea
            WHERE CompanyId = @CompanyID
                AND Therapy = @Therapy
            );
END

UPDATE PSProgram
SET TherapyId = @TherapyId
WHERE ProgramID = @ProgramID;


COMMIT