package com.kh.styleblending.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Declare {

	private int dno; // 신고번호
	private int mno; // 신고한 회원번호
	private String email; // 신고한 회원이메일
	private int bno; // 신고한 포스팅,게시판 번호
	private String category; // 신고사유 카테고리
	private String content; // 사유 기타시 내용
	private Date enrollDate; // 신고일자
	private String isCheck; // 신고상태 
	private int type; // 게시판 타입(1-포스팅,2-자유)
	private String bname; // type1-포스팅 이미지, 2-게시물제목
	private int writerMno; // 글쓴이 회원번호
	private String writer; // 신고 포스팅 글쓴이
	private String renameImg; // 신고한 회원이미지
	private String profilePath; // 신고한 회원 이미지경로
	private String writerImg; // 글쓴이 회원이미지
	private String writerPath; // 글쓴이 이미지 경로
	
	

}
