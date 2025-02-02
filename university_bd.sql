PGDMP  !    $                |            UniversityDB    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16397    UniversityDB    DATABASE     �   CREATE DATABASE "UniversityDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "UniversityDB";
                postgres    false            �            1259    16410    courses    TABLE     �   CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_name character varying(255) NOT NULL,
    description character varying(255),
    credits integer NOT NULL,
    department character varying(255) NOT NULL
);
    DROP TABLE public.courses;
       public         heap    postgres    false            �            1259    16409    courses_course_id_seq    SEQUENCE     �   CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.courses_course_id_seq;
       public          postgres    false    218            �           0    0    courses_course_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;
          public          postgres    false    217            �            1259    16419    enrollments    TABLE     �   CREATE TABLE public.enrollments (
    enrollment_id integer NOT NULL,
    student_id integer NOT NULL,
    course_id integer NOT NULL,
    enrollment_date date NOT NULL,
    grade character varying(255)
);
    DROP TABLE public.enrollments;
       public         heap    postgres    false            �            1259    16418    enrollments_enrollment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.enrollments_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.enrollments_enrollment_id_seq;
       public          postgres    false    220            �           0    0    enrollments_enrollment_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNED BY public.enrollments.enrollment_id;
          public          postgres    false    219            �            1259    16399    students    TABLE     w  CREATE TABLE public.students (
    student_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    email character varying(255) NOT NULL,
    phone_number character varying(255),
    address character varying(255),
    enrollment_date date NOT NULL,
    gpa double precision
);
    DROP TABLE public.students;
       public         heap    postgres    false            �            1259    16435    student_enrollments    VIEW     O  CREATE VIEW public.student_enrollments AS
 SELECT students.student_id,
    courses.course_name,
    enrollments.enrollment_date,
    enrollments.grade
   FROM ((public.students
     JOIN public.enrollments ON ((students.student_id = enrollments.student_id)))
     JOIN public.courses ON ((enrollments.course_id = courses.course_id)));
 &   DROP VIEW public.student_enrollments;
       public          postgres    false    220    218    218    220    216    220    220            �            1259    16398    students_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.students_student_id_seq;
       public          postgres    false    216            �           0    0    students_student_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;
          public          postgres    false    215            )           2604    16413    courses course_id    DEFAULT     v   ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);
 @   ALTER TABLE public.courses ALTER COLUMN course_id DROP DEFAULT;
       public          postgres    false    218    217    218            *           2604    16422    enrollments enrollment_id    DEFAULT     �   ALTER TABLE ONLY public.enrollments ALTER COLUMN enrollment_id SET DEFAULT nextval('public.enrollments_enrollment_id_seq'::regclass);
 H   ALTER TABLE public.enrollments ALTER COLUMN enrollment_id DROP DEFAULT;
       public          postgres    false    219    220    220            (           2604    16402    students student_id    DEFAULT     z   ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);
 B   ALTER TABLE public.students ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    16410    courses 
   TABLE DATA           [   COPY public.courses (course_id, course_name, description, credits, department) FROM stdin;
    public          postgres    false    218   �#       �          0    16419    enrollments 
   TABLE DATA           c   COPY public.enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) FROM stdin;
    public          postgres    false    220   n%       �          0    16399    students 
   TABLE DATA           �   COPY public.students (student_id, first_name, last_name, date_of_birth, email, phone_number, address, enrollment_date, gpa) FROM stdin;
    public          postgres    false    216   �%       �           0    0    courses_course_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.courses_course_id_seq', 5, true);
          public          postgres    false    217            �           0    0    enrollments_enrollment_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.enrollments_enrollment_id_seq', 10, true);
          public          postgres    false    219            �           0    0    students_student_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.students_student_id_seq', 5, true);
          public          postgres    false    215            0           2606    16417    courses courses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public            postgres    false    218            2           2606    16424    enrollments enrollments_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);
 F   ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_pkey;
       public            postgres    false    220            ,           2606    16408    students students_email_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);
 E   ALTER TABLE ONLY public.students DROP CONSTRAINT students_email_key;
       public            postgres    false    216            .           2606    16406    students students_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public            postgres    false    216            3           2606    16430 &   enrollments enrollments_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);
 P   ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_course_id_fkey;
       public          postgres    false    4656    220    218            4           2606    16425 '   enrollments enrollments_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);
 Q   ALTER TABLE ONLY public.enrollments DROP CONSTRAINT enrollments_student_id_fkey;
       public          postgres    false    216    220    4654            �   �  x��SMN�P^��b�$�����M���%1. ��2�<�IA_Z��+���o^хV������73�|l��[~ŷ��-�x)=.�g�|rw����~��KI��2���3�R��>OH�R�@5����`Ƶ�	�s�����ɤa�? �|=�SMF���4�$	��G�:F�LT�!)����r�/dT�~)C-	��+mu�k�o�� 	\2v�XL���k���ʠLҭ�+��9m�lC�ŷH�m�]���q@{Wq'8���I�Qt��jGݰ��S���0��蘚�Iq��x�:'A�&��:��N�ǿJ�z�j�Srk��9UM5Z#0~n�/ܺu��K�����5L���T�h ��j1 sZW+Q���h}���R�r���+��ݮ��Zk����=,���d��	-�UF�!.56�يsF��aj�� ��4<�� 3!i      �   N   x�eʻ�0��׋�}7A��"�E�=�C�S�T�o���b��KX�W-�����}7��[�����>D��"�      �   �   x���ˊ�@E�7��M���fd6�B7njL1���h��{��}�l�8T�O�{��J���6���4D�'�n��5\�kl��F�N���{��cp��:e���"멬����c�"O�'D7�:{=��iq����8;��I|m�iL�i�ϷYl�prᑱ��ř�2+=ͮ�?e^�\tUU/O�c�     