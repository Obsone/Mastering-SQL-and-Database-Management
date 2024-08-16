CREATE DOMAIN Rating SMALLINT
    CHECK (VALUE > 0 AND VALUE <= 5);
    
CREATE TYPE Feedback AS (
    student_id UUID,
    rating Rating,
    feedback TEXT
);

--CREATE extension IF NOT EXISTS "uuid-ossp";

CREATE TABLE course (
    course_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), --course_id is primary Key(PK)
    "name" TEXT NOT NULL,
    description TEXT,
    subject_id UUID REFERENCES subject(subject_id), --referencing foreign keys(FK)
    teacher_id UUID REFERENCES teacher(teacher_id), 
    feedback feedback[]
);