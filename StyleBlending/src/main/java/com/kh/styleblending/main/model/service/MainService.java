package com.kh.styleblending.main.model.service;

import java.util.ArrayList;

import com.kh.styleblending.admin.model.vo.Ad;
import com.kh.styleblending.main.model.vo.Live;
import com.kh.styleblending.main.model.vo.Notice;
import com.kh.styleblending.posting.model.vo.Posting;

public interface MainService {
	
	//메인 상단 좋아요 순 4개 사진
	ArrayList<Posting> selectFourWrap();
	//메인 나머지 리스트 최신순
	ArrayList<Posting> selectPostList(int mno);
	//메인 무한스크롤 리스트
	ArrayList<Posting> selectInfinityScroll(int mno);
	//광고 url/ 사진 가져옫기
	Ad selectAd();
	//필터 기능 검색
	ArrayList<Posting> selectFilter(Posting p, int mno);
	//좋아요 증가
	int increaseLikeCount(int pno);
	//공지사항 내용 보여주기
	ArrayList<Notice> selectNoticeContent(int nno);
	//공지사항 등록 하기
	int insertNotice(Notice n);
	//공지사항 수정 등록
	int noticeUpdateConfirm(Notice n);
	//공지사항 삭제
	int noticeDelete(int nno);
	ArrayList<Live> topSearch();
	
	
}
