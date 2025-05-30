PGDMP                      }            enrollment_db    17.4    17.4 f    V           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            W           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            X           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            Y           1262    59237    enrollment_db    DATABASE     �   CREATE DATABASE enrollment_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';
    DROP DATABASE enrollment_db;
                     postgres    false            �            1259    59238    academic_year    TABLE     �   CREATE TABLE public.academic_year (
    ay_code character varying(20) NOT NULL,
    ay_start_year integer NOT NULL,
    ay_end_year integer NOT NULL,
    CONSTRAINT valid_year_range CHECK ((ay_end_year = (ay_start_year + 1)))
);
 !   DROP TABLE public.academic_year;
       public         heap r       postgres    false            �            1259    59242    block_section    TABLE     .  CREATE TABLE public.block_section (
    bsec_code character varying(20) NOT NULL,
    bsec_name character varying(100) NOT NULL,
    bsec_status character varying(20) DEFAULT true,
    prog_code character varying(50) NOT NULL,
    ay_code character varying(20) NOT NULL,
    sem_id integer NOT NULL
);
 !   DROP TABLE public.block_section;
       public         heap r       postgres    false            �            1259    59246    course    TABLE     W  CREATE TABLE public.course (
    crs_code character varying(50) NOT NULL,
    crs_title character varying(100) NOT NULL,
    crs_units numeric(3,1) NOT NULL,
    crs_lec integer NOT NULL,
    crs_lab integer NOT NULL,
    crs_totalhours time without time zone,
    preq_id character varying(50),
    ctg_code character varying(50) NOT NULL
);
    DROP TABLE public.course;
       public         heap r       postgres    false            �            1259    59249    course_category    TABLE     �   CREATE TABLE public.course_category (
    ctg_code character varying(50) NOT NULL,
    ctg_name character varying(100) NOT NULL
);
 #   DROP TABLE public.course_category;
       public         heap r       postgres    false            �            1259    67282    course_taken    TABLE     �   CREATE TABLE public.course_taken (
    stud_id integer NOT NULL,
    crs_code character varying(50) NOT NULL,
    crst_status character varying(20) NOT NULL
);
     DROP TABLE public.course_taken;
       public         heap r       postgres    false            �            1259    59345 
   curriculum    TABLE     �   CREATE TABLE public.curriculum (
    cur_code character varying(20) NOT NULL,
    prog_code character varying(50) NOT NULL,
    ay_code character varying(20) NOT NULL
);
    DROP TABLE public.curriculum;
       public         heap r       postgres    false            �            1259    67261    curriculum_course    TABLE       CREATE TABLE public.curriculum_course (
    cur_code character varying(50) NOT NULL,
    crs_code character varying(50) NOT NULL,
    cur_year_level character varying(50),
    cur_semester character varying(50),
    ay_code character varying(50),
    prog_code character varying(50)
);
 %   DROP TABLE public.curriculum_course;
       public         heap r       postgres    false            �            1259    59252    faculty    TABLE     $  CREATE TABLE public.faculty (
    id integer NOT NULL,
    fullname character varying(150) NOT NULL,
    username character varying(100) NOT NULL,
    password text NOT NULL,
    isprofessor boolean DEFAULT false,
    isadmin boolean DEFAULT false,
    isprogramhead boolean DEFAULT false
);
    DROP TABLE public.faculty;
       public         heap r       postgres    false            �            1259    59260    faculty_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.faculty_id_seq;
       public               postgres    false    221            Z           0    0    faculty_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.faculty_id_seq OWNED BY public.faculty.id;
          public               postgres    false    222            �            1259    59261    prerequisite    TABLE     {   CREATE TABLE public.prerequisite (
    crs_code character varying(50) NOT NULL,
    preq_crs_code character varying(50)
);
     DROP TABLE public.prerequisite;
       public         heap r       postgres    false            �            1259    67312 	   professor    TABLE     �   CREATE TABLE public.professor (
    prof_id integer NOT NULL,
    prof_name character varying(100) NOT NULL,
    prog_code character varying(50) NOT NULL
);
    DROP TABLE public.professor;
       public         heap r       postgres    false            �            1259    67311    professor_prof_id_seq    SEQUENCE     �   CREATE SEQUENCE public.professor_prof_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.professor_prof_id_seq;
       public               postgres    false    235            [           0    0    professor_prof_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.professor_prof_id_seq OWNED BY public.professor.prof_id;
          public               postgres    false    234            �            1259    59264    program    TABLE     ~   CREATE TABLE public.program (
    prog_code character varying(50) NOT NULL,
    prog_title character varying(100) NOT NULL
);
    DROP TABLE public.program;
       public         heap r       postgres    false            �            1259    67298    room    TABLE     �   CREATE TABLE public.room (
    room_id integer NOT NULL,
    room_code character varying(20) NOT NULL,
    prog_code character varying(50) NOT NULL
);
    DROP TABLE public.room;
       public         heap r       postgres    false            �            1259    67297    room_room_id_seq    SEQUENCE     �   CREATE SEQUENCE public.room_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.room_room_id_seq;
       public               postgres    false    233            \           0    0    room_room_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;
          public               postgres    false    232            �            1259    67330    schedule    TABLE     �   CREATE TABLE public.schedule (
    schd_id integer NOT NULL,
    crs_code character varying(50) NOT NULL,
    room_id integer NOT NULL,
    bsec_code character varying(20) NOT NULL,
    prof_id integer NOT NULL
);
    DROP TABLE public.schedule;
       public         heap r       postgres    false            �            1259    67329    schedule_schd_id_seq    SEQUENCE     �   CREATE SEQUENCE public.schedule_schd_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.schedule_schd_id_seq;
       public               postgres    false    237            ]           0    0    schedule_schd_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.schedule_schd_id_seq OWNED BY public.schedule.schd_id;
          public               postgres    false    236            �            1259    59267    semester    TABLE     k   CREATE TABLE public.semester (
    sem_id integer NOT NULL,
    sem_name character varying(50) NOT NULL
);
    DROP TABLE public.semester;
       public         heap r       postgres    false            �            1259    59270    semester_sem_id_seq    SEQUENCE     �   CREATE SEQUENCE public.semester_sem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.semester_sem_id_seq;
       public               postgres    false    225            ^           0    0    semester_sem_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.semester_sem_id_seq OWNED BY public.semester.sem_id;
          public               postgres    false    226            �            1259    59271    student    TABLE     �  CREATE TABLE public.student (
    stud_id integer NOT NULL,
    stud_fname character varying(50) NOT NULL,
    stud_lname character varying(50) NOT NULL,
    stud_mname character varying(50),
    stud_email character varying(100) NOT NULL,
    stud_code integer NOT NULL,
    stud_dob date NOT NULL,
    stud_contact character varying(20) NOT NULL,
    stud_address text,
    stud_district character varying(50),
    stud_is_first_gen boolean DEFAULT false,
    stud_yr_level integer,
    stud_major character varying(100),
    stud_status character varying(20),
    stud_sem integer,
    bsec_code character varying(20),
    prog_code character varying(50),
    stud_password character varying(255) NOT NULL
);
    DROP TABLE public.student;
       public         heap r       postgres    false            �            1259    59277    student_stud_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_stud_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.student_stud_id_seq;
       public               postgres    false    227            _           0    0    student_stud_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.student_stud_id_seq OWNED BY public.student.stud_id;
          public               postgres    false    228            �            1259    67359 	   time_slot    TABLE       CREATE TABLE public.time_slot (
    schd_id integer NOT NULL,
    tsl_start_time time without time zone NOT NULL,
    tsl_end_time time without time zone NOT NULL,
    tsl_day character varying(10) NOT NULL,
    CONSTRAINT valid_time_slot CHECK ((tsl_end_time > tsl_start_time))
);
    DROP TABLE public.time_slot;
       public         heap r       postgres    false            c           2604    59278 
   faculty id    DEFAULT     h   ALTER TABLE ONLY public.faculty ALTER COLUMN id SET DEFAULT nextval('public.faculty_id_seq'::regclass);
 9   ALTER TABLE public.faculty ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            k           2604    67315    professor prof_id    DEFAULT     v   ALTER TABLE ONLY public.professor ALTER COLUMN prof_id SET DEFAULT nextval('public.professor_prof_id_seq'::regclass);
 @   ALTER TABLE public.professor ALTER COLUMN prof_id DROP DEFAULT;
       public               postgres    false    234    235    235            j           2604    67301    room room_id    DEFAULT     l   ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);
 ;   ALTER TABLE public.room ALTER COLUMN room_id DROP DEFAULT;
       public               postgres    false    232    233    233            l           2604    67333    schedule schd_id    DEFAULT     t   ALTER TABLE ONLY public.schedule ALTER COLUMN schd_id SET DEFAULT nextval('public.schedule_schd_id_seq'::regclass);
 ?   ALTER TABLE public.schedule ALTER COLUMN schd_id DROP DEFAULT;
       public               postgres    false    236    237    237            g           2604    59279    semester sem_id    DEFAULT     r   ALTER TABLE ONLY public.semester ALTER COLUMN sem_id SET DEFAULT nextval('public.semester_sem_id_seq'::regclass);
 >   ALTER TABLE public.semester ALTER COLUMN sem_id DROP DEFAULT;
       public               postgres    false    226    225            h           2604    59280    student stud_id    DEFAULT     r   ALTER TABLE ONLY public.student ALTER COLUMN stud_id SET DEFAULT nextval('public.student_stud_id_seq'::regclass);
 >   ALTER TABLE public.student ALTER COLUMN stud_id DROP DEFAULT;
       public               postgres    false    228    227            >          0    59238    academic_year 
   TABLE DATA           L   COPY public.academic_year (ay_code, ay_start_year, ay_end_year) FROM stdin;
    public               postgres    false    217   ��       ?          0    59242    block_section 
   TABLE DATA           f   COPY public.block_section (bsec_code, bsec_name, bsec_status, prog_code, ay_code, sem_id) FROM stdin;
    public               postgres    false    218   u�       @          0    59246    course 
   TABLE DATA           u   COPY public.course (crs_code, crs_title, crs_units, crs_lec, crs_lab, crs_totalhours, preq_id, ctg_code) FROM stdin;
    public               postgres    false    219   ��       A          0    59249    course_category 
   TABLE DATA           =   COPY public.course_category (ctg_code, ctg_name) FROM stdin;
    public               postgres    false    220   '�       L          0    67282    course_taken 
   TABLE DATA           F   COPY public.course_taken (stud_id, crs_code, crst_status) FROM stdin;
    public               postgres    false    231   �       J          0    59345 
   curriculum 
   TABLE DATA           B   COPY public.curriculum (cur_code, prog_code, ay_code) FROM stdin;
    public               postgres    false    229   ��       K          0    67261    curriculum_course 
   TABLE DATA           q   COPY public.curriculum_course (cur_code, crs_code, cur_year_level, cur_semester, ay_code, prog_code) FROM stdin;
    public               postgres    false    230   �       B          0    59252    faculty 
   TABLE DATA           h   COPY public.faculty (id, fullname, username, password, isprofessor, isadmin, isprogramhead) FROM stdin;
    public               postgres    false    221   e�       D          0    59261    prerequisite 
   TABLE DATA           ?   COPY public.prerequisite (crs_code, preq_crs_code) FROM stdin;
    public               postgres    false    223   �       P          0    67312 	   professor 
   TABLE DATA           B   COPY public.professor (prof_id, prof_name, prog_code) FROM stdin;
    public               postgres    false    235   M�       E          0    59264    program 
   TABLE DATA           8   COPY public.program (prog_code, prog_title) FROM stdin;
    public               postgres    false    224   j�       N          0    67298    room 
   TABLE DATA           =   COPY public.room (room_id, room_code, prog_code) FROM stdin;
    public               postgres    false    233   ��       R          0    67330    schedule 
   TABLE DATA           R   COPY public.schedule (schd_id, crs_code, room_id, bsec_code, prof_id) FROM stdin;
    public               postgres    false    237   �       F          0    59267    semester 
   TABLE DATA           4   COPY public.semester (sem_id, sem_name) FROM stdin;
    public               postgres    false    225   6�       H          0    59271    student 
   TABLE DATA             COPY public.student (stud_id, stud_fname, stud_lname, stud_mname, stud_email, stud_code, stud_dob, stud_contact, stud_address, stud_district, stud_is_first_gen, stud_yr_level, stud_major, stud_status, stud_sem, bsec_code, prog_code, stud_password) FROM stdin;
    public               postgres    false    227   x�       S          0    67359 	   time_slot 
   TABLE DATA           S   COPY public.time_slot (schd_id, tsl_start_time, tsl_end_time, tsl_day) FROM stdin;
    public               postgres    false    238   �       `           0    0    faculty_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.faculty_id_seq', 3, true);
          public               postgres    false    222            a           0    0    professor_prof_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.professor_prof_id_seq', 1, false);
          public               postgres    false    234            b           0    0    room_room_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.room_room_id_seq', 1, false);
          public               postgres    false    232            c           0    0    schedule_schd_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.schedule_schd_id_seq', 1, false);
          public               postgres    false    236            d           0    0    semester_sem_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.semester_sem_id_seq', 1, false);
          public               postgres    false    226            e           0    0    student_stud_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.student_stud_id_seq', 1, true);
          public               postgres    false    228            p           2606    59282     academic_year academic_year_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.academic_year
    ADD CONSTRAINT academic_year_pkey PRIMARY KEY (ay_code);
 J   ALTER TABLE ONLY public.academic_year DROP CONSTRAINT academic_year_pkey;
       public                 postgres    false    217            r           2606    59284     block_section block_section_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.block_section
    ADD CONSTRAINT block_section_pkey PRIMARY KEY (bsec_code);
 J   ALTER TABLE ONLY public.block_section DROP CONSTRAINT block_section_pkey;
       public                 postgres    false    218            v           2606    59286 $   course_category course_category_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.course_category
    ADD CONSTRAINT course_category_pkey PRIMARY KEY (ctg_code);
 N   ALTER TABLE ONLY public.course_category DROP CONSTRAINT course_category_pkey;
       public                 postgres    false    220            t           2606    59288    course course_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (crs_code);
 <   ALTER TABLE ONLY public.course DROP CONSTRAINT course_pkey;
       public                 postgres    false    219            �           2606    67286    course_taken course_taken_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.course_taken
    ADD CONSTRAINT course_taken_pkey PRIMARY KEY (stud_id, crs_code);
 H   ALTER TABLE ONLY public.course_taken DROP CONSTRAINT course_taken_pkey;
       public                 postgres    false    231    231            �           2606    67265 (   curriculum_course curriculum_course_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.curriculum_course
    ADD CONSTRAINT curriculum_course_pkey PRIMARY KEY (cur_code, crs_code);
 R   ALTER TABLE ONLY public.curriculum_course DROP CONSTRAINT curriculum_course_pkey;
       public                 postgres    false    230    230            �           2606    59349    curriculum curriculum_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (cur_code);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_pkey;
       public                 postgres    false    229            x           2606    59290    faculty faculty_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_pkey;
       public                 postgres    false    221            z           2606    59292    faculty faculty_username_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.faculty
    ADD CONSTRAINT faculty_username_key UNIQUE (username);
 F   ALTER TABLE ONLY public.faculty DROP CONSTRAINT faculty_username_key;
       public                 postgres    false    221            |           2606    59294    prerequisite prerequisite_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.prerequisite
    ADD CONSTRAINT prerequisite_pkey PRIMARY KEY (crs_code);
 H   ALTER TABLE ONLY public.prerequisite DROP CONSTRAINT prerequisite_pkey;
       public                 postgres    false    223            �           2606    67317    professor professor_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_pkey PRIMARY KEY (prof_id);
 B   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_pkey;
       public                 postgres    false    235            ~           2606    59296    program program_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (prog_code);
 >   ALTER TABLE ONLY public.program DROP CONSTRAINT program_pkey;
       public                 postgres    false    224            �           2606    67303    room room_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public                 postgres    false    233            �           2606    67305    room room_room_code_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_room_code_key UNIQUE (room_code);
 A   ALTER TABLE ONLY public.room DROP CONSTRAINT room_room_code_key;
       public                 postgres    false    233            �           2606    67335    schedule schedule_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schd_id);
 @   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_pkey;
       public                 postgres    false    237            �           2606    59298    semester semester_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.semester
    ADD CONSTRAINT semester_pkey PRIMARY KEY (sem_id);
 @   ALTER TABLE ONLY public.semester DROP CONSTRAINT semester_pkey;
       public                 postgres    false    225            �           2606    59300    student student_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (stud_id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public                 postgres    false    227            �           2606    59302    student student_stud_code_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_stud_code_key UNIQUE (stud_code);
 G   ALTER TABLE ONLY public.student DROP CONSTRAINT student_stud_code_key;
       public                 postgres    false    227            �           2606    59304    student student_stud_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_stud_email_key UNIQUE (stud_email);
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_stud_email_key;
       public                 postgres    false    227            �           2606    67364    time_slot time_slot_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.time_slot
    ADD CONSTRAINT time_slot_pkey PRIMARY KEY (schd_id, tsl_start_time, tsl_day);
 B   ALTER TABLE ONLY public.time_slot DROP CONSTRAINT time_slot_pkey;
       public                 postgres    false    238    238    238            �           2606    59305 (   block_section block_section_ay_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.block_section
    ADD CONSTRAINT block_section_ay_code_fkey FOREIGN KEY (ay_code) REFERENCES public.academic_year(ay_code);
 R   ALTER TABLE ONLY public.block_section DROP CONSTRAINT block_section_ay_code_fkey;
       public               postgres    false    217    4720    218            �           2606    59310 *   block_section block_section_prog_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.block_section
    ADD CONSTRAINT block_section_prog_code_fkey FOREIGN KEY (prog_code) REFERENCES public.program(prog_code);
 T   ALTER TABLE ONLY public.block_section DROP CONSTRAINT block_section_prog_code_fkey;
       public               postgres    false    4734    224    218            �           2606    59315 '   block_section block_section_sem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.block_section
    ADD CONSTRAINT block_section_sem_id_fkey FOREIGN KEY (sem_id) REFERENCES public.semester(sem_id);
 Q   ALTER TABLE ONLY public.block_section DROP CONSTRAINT block_section_sem_id_fkey;
       public               postgres    false    4736    225    218            �           2606    59320    course course_ctg_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_ctg_code_fkey FOREIGN KEY (ctg_code) REFERENCES public.course_category(ctg_code) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.course DROP CONSTRAINT course_ctg_code_fkey;
       public               postgres    false    219    4726    220            �           2606    67292 '   course_taken course_taken_crs_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course_taken
    ADD CONSTRAINT course_taken_crs_code_fkey FOREIGN KEY (crs_code) REFERENCES public.course(crs_code) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.course_taken DROP CONSTRAINT course_taken_crs_code_fkey;
       public               postgres    false    4724    219    231            �           2606    67287 &   course_taken course_taken_stud_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.course_taken
    ADD CONSTRAINT course_taken_stud_id_fkey FOREIGN KEY (stud_id) REFERENCES public.student(stud_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.course_taken DROP CONSTRAINT course_taken_stud_id_fkey;
       public               postgres    false    4738    227    231            �           2606    59355 "   curriculum curriculum_ay_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_ay_code_fkey FOREIGN KEY (ay_code) REFERENCES public.academic_year(ay_code);
 L   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_ay_code_fkey;
       public               postgres    false    4720    229    217            �           2606    59350 $   curriculum curriculum_prog_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_prog_code_fkey FOREIGN KEY (prog_code) REFERENCES public.program(prog_code) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_prog_code_fkey;
       public               postgres    false    229    4734    224            �           2606    67276 "   curriculum_course fk_academic_year    FK CONSTRAINT     �   ALTER TABLE ONLY public.curriculum_course
    ADD CONSTRAINT fk_academic_year FOREIGN KEY (ay_code) REFERENCES public.academic_year(ay_code);
 L   ALTER TABLE ONLY public.curriculum_course DROP CONSTRAINT fk_academic_year;
       public               postgres    false    4720    230    217            �           2606    67266    curriculum_course fk_course    FK CONSTRAINT     �   ALTER TABLE ONLY public.curriculum_course
    ADD CONSTRAINT fk_course FOREIGN KEY (crs_code) REFERENCES public.course(crs_code);
 E   ALTER TABLE ONLY public.curriculum_course DROP CONSTRAINT fk_course;
       public               postgres    false    230    4724    219            �           2606    67271    curriculum_course fk_program    FK CONSTRAINT     �   ALTER TABLE ONLY public.curriculum_course
    ADD CONSTRAINT fk_program FOREIGN KEY (prog_code) REFERENCES public.program(prog_code);
 F   ALTER TABLE ONLY public.curriculum_course DROP CONSTRAINT fk_program;
       public               postgres    false    224    230    4734            �           2606    59325 '   prerequisite prerequisite_crs_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prerequisite
    ADD CONSTRAINT prerequisite_crs_code_fkey FOREIGN KEY (crs_code) REFERENCES public.course(crs_code);
 Q   ALTER TABLE ONLY public.prerequisite DROP CONSTRAINT prerequisite_crs_code_fkey;
       public               postgres    false    223    4724    219            �           2606    59330 ,   prerequisite prerequisite_preq_crs_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.prerequisite
    ADD CONSTRAINT prerequisite_preq_crs_code_fkey FOREIGN KEY (preq_crs_code) REFERENCES public.course(crs_code);
 V   ALTER TABLE ONLY public.prerequisite DROP CONSTRAINT prerequisite_preq_crs_code_fkey;
       public               postgres    false    223    4724    219            �           2606    67318 "   professor professor_prog_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.professor
    ADD CONSTRAINT professor_prog_code_fkey FOREIGN KEY (prog_code) REFERENCES public.program(prog_code);
 L   ALTER TABLE ONLY public.professor DROP CONSTRAINT professor_prog_code_fkey;
       public               postgres    false    235    224    4734            �           2606    67306    room room_prog_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_prog_code_fkey FOREIGN KEY (prog_code) REFERENCES public.program(prog_code);
 B   ALTER TABLE ONLY public.room DROP CONSTRAINT room_prog_code_fkey;
       public               postgres    false    233    224    4734            �           2606    67346     schedule schedule_bsec_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_bsec_code_fkey FOREIGN KEY (bsec_code) REFERENCES public.block_section(bsec_code);
 J   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_bsec_code_fkey;
       public               postgres    false    218    4722    237            �           2606    67336    schedule schedule_crs_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_crs_code_fkey FOREIGN KEY (crs_code) REFERENCES public.course(crs_code);
 I   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_crs_code_fkey;
       public               postgres    false    219    4724    237            �           2606    67351    schedule schedule_prof_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_prof_id_fkey FOREIGN KEY (prof_id) REFERENCES public.professor(prof_id);
 H   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_prof_id_fkey;
       public               postgres    false    4754    237    235            �           2606    67341    schedule schedule_room_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);
 H   ALTER TABLE ONLY public.schedule DROP CONSTRAINT schedule_room_id_fkey;
       public               postgres    false    233    237    4750            �           2606    59335    student student_bsec_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_bsec_code_fkey FOREIGN KEY (bsec_code) REFERENCES public.block_section(bsec_code) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_bsec_code_fkey;
       public               postgres    false    4722    218    227            �           2606    59340    student student_prog_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_prog_code_fkey FOREIGN KEY (prog_code) REFERENCES public.program(prog_code) ON UPDATE CASCADE ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_prog_code_fkey;
       public               postgres    false    224    4734    227            �           2606    67365     time_slot time_slot_schd_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.time_slot
    ADD CONSTRAINT time_slot_schd_id_fkey FOREIGN KEY (schd_id) REFERENCES public.schedule(schd_id) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.time_slot DROP CONSTRAINT time_slot_schd_id_fkey;
       public               postgres    false    237    4756    238            >   �   x�5���1C�3�K��Eٞc���ױ�9���}�����	}:�}�N���ץu�����ިt{�k\xR\g�KkǓ�{�Z*�Ck�Rx�D%z��D��*[LT�-d��J��l�Qɶ�-�$�B6�m�l�xm�l�dec��m��D%�(�l�l��de�B%�(7*�F�x '�F�� �Ҷ�-;�����[k�Si�      ?      x������ � �      @   �   x�e�1�0���W��\�tg)&�vt	\:�`�?ԆR�.o��{�Cu
؏�w���{�[�m
fn[���a�y���Z3�=7�.?IK,r�yf�G�+cʒ4��,j��$)	�7��!���8,y      A   �   x�]�A
�0EיS� V�H��m�]���������7m������s�s)s� �lO�Ҷ2b��z�O9��>��zZ6��B#»;�����«�!��b�Y�n��R[m;�����J���IvGg��nq"�G�j��Qɘޠ�A���x�~�
�A�
;/\� ���W�      L      x������ � �      J   �   x�mQ=�0����A�Mt�����E���^�=[$a��>r�U��qQv�~�&��w&�����U'�����G߇����;y=�Nݜ�n���K7���	�}3w��0D���oߟ�-2����CΌb}�$$��B��H(���E0�ML��;9`��$V���B�%�R�d	`\��E�)��Ȩ���PV�m�= ��H���pL�F>n���F-	YA�K�8�B���8K�ei�����'      K   Q   x�s
�u
v�u�4202�5261���%
���E�Fy)
�����%�E�0eF� }\��&�����pBH"͈���� ?$�      B   �   x��ϻ�0����Ut`n8L�Xb�Ԩ�˟�U������g��|M�ݎ���Rn�>kk�������0~L�ϛ�ܳ<-���U<��j���|F�}�L�|�d�� (P$�X���;4�R�d脵N�%���cOt��'�C��K�`����6@��Ư\Q      D   "   x�3261��140�JKOIO�4
p��qqq S��      P      x������ � �      E   �  x��U���0=���=l���*d�i/�x�,�
6��V�}�RH��7ļg�o���p��HUAm�0"WZ�@-���Fz4Z\@U�Ԧ�$��ec���`�w��`��Z��D`Q���XtFH�J�SR��֠�]��M�Crw���fϱb�*���l�s��2��R��c���ї�qѠF��0��:۸�Z:�*l	��8�޸����"�Z�Ѐ�D�����,�f�i�͂[�Fh�0����lj:kJ%�Ð����zUq��ɋ	VD�@)k�T"M;\g���#�H��g��JRl�	gl�2(�;σ���N^��H�N�,P<�3��2�X �S�o��)���pl$��k?�ņ�:��?���������M�H����g��� �����d�
��yh\���G|�A��%�&��f���r�\U�艷�P�
�O]HN�<΍ZM��b�+��#J�L[Ԟ�\E��	��Ҳ������E��`;ca�<�!"s�� �p��%C���"x�Df�9��I�mh��*յè��r���g�RQ�\��z5�
�(x����X�]k������#gn�PG�ۉ�/a���Q4�otf�Ɲ�B�|3�WP����������ڲ�J/oY��=��?4K�      N      x������ � �      R      x������ � �      F   2   x�3�4,.QN�M-.I-�2�4�K�s���9��|.N��7F��� �W      H   �   x�]�=�0 ���`��Q݌:������B���������Pвj�6�j@hٵ=�ί�.��E�=�v�(NdGD�Yӎ���B���@�s����SZ���G=
ӻ͗W����.�Y�or~4T0j?6�ʝ�w�"|/�      S      x������ � �     