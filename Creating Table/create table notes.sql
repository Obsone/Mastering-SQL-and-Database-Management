CREATE DOMAIN Rating SMALLINT
    CHECK (VALUE > 0 AND VALUE <= 5);
    
CREATE TYPE Feedback AS (
    student_id UUID,
    rating Rating,
    feedback TEXT
);

--CREATE extension IF NOT EXISTS "uuid-ossp";

CREATE TABLE student (
    student_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), --course_id is primary Key(PK)
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email TEXT,
    date_of_birth DATE NOT NULL
)

CREATE TABLE subject (
    subject_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subject TEXT NOT NULL,
    description TEXT
)

CREATE TABLE course (
    course_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), --course_id is primary Key(PK)
    "name" TEXT NOT NULL,
    description TEXT,
    subject_id UUID REFERENCES subject(subject_id), --referencing foreign keys(FK)
    teacher_id UUID REFERENCES teacher(teacher_id), 
    feedback feedback[]
);

CREATE TABLE enrollment (
    course_id UUID REFERENCES course(course_id),
    student_id UUID REFERENCES student(student_id),
    enrollment_date DATE NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (course_id, student_id)
);

--INSERT

INSERT INTO teacher (
    first_name,
    last_name,
    email,
    date_of_birth
) VALUES (
    'Mo',
    'Binni',
    'mo@binni.io',
    '1992-11-13'::DATE
);

INSERT INTO subject (
    subject,
    description
) VALUES (
    'SQL',
    'A database management language'
);

DELETE FROM subject WHERE subject = 'SQL course';

INSERT INTO course (
    "name",
    description
) VALUES (
    'SQL mastery',
    'Introduction to SQL'
);

--UPDATE
/*this is where we notice that subject_id and teacher_id on course table contains null where it shouldn't
*/
/* 
teacher and subject obviously should not be NULL...
before we can ALTER the course to set NOT NULL we use UPDATE  the course and set the PK of teacher_id.
 if we ALTER first an error will occur stating teacher_id contains null.
 
 -same thing to subject
*/
UPDATE course
SET teacher_id = 'a266f9c8-289f-4610-bb3e-21e03b07915d'
WHERE teacher_id IS NULL;

ALTER TABLE course ALTER COLUMN teacher_id SET NOT NULL;

UPDATE course
SET subject_id = '1bf2b0c7-20a9-416f-a5a7-813b556871a1'
WHERE subject_id IS NULL;

ALTER TABLE course ALTER COLUMN subject_id SET NOT NULL;

--if we did try to INSERT INTO course not including subject_id/teacher_id that now we set to be NOT NULL
-- 15:01:07 Kernel error: ERROR:  null value in column "subject_id" of relation "course" violates not-null constraint
INSERT INTO course (
    "name",
    description
) VALUES (
    'name',
    'description');

INSERT INTO enrollment (
    student_id,
    course_id,
    enrollment_date
) VALUES (
    'c04a9d62-ac12-46ee-b7ac-6c52f2870319',
    'b94ec2cd-37b6-49fb-87e6-bd2e73fc0c53',
    NOW()::DATE
);

UPDATE course
SET feedback = array_append (
    feedback,
    ROW(
        'c04a9d62-ac12-46ee-b7ac-6c52f2870319',
        5,
        'great course!'
    )::feedback
)
WHERE course_id = 'b94ec2cd-37b6-49fb-87e6-bd2e73fc0c53'
------------------------------------------------------------------
CREATE TABLE feedback (
    student_id UUID NOT NULL REFERENCES student(student_id),
    course_id UUID NOT NULL REFERENCES course(course_id),
    feedback TEXT,
    rating rating,
    CONSTRAINT pk_feedback PRIMARY KEY (student_id, course_id)
);
--error: relation feedback already exists
/*right click types feedback-design and course-design  renaming feeback_deprecated
*/ 

INSERT INTO feedback (
    student_id,
    course_id,
    feedback,
    rating
) VALUES (
    'c04a9d62-ac12-46ee-b7ac-6c52f2870319',
    'b94ec2cd-37b6-49fb-87e6-bd2e73fc0c53',
    'pretty awesome!',
    4
);