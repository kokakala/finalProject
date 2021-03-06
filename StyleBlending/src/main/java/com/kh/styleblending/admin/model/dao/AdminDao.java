package com.kh.styleblending.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.styleblending.admin.model.vo.Ad;
import com.kh.styleblending.admin.model.vo.Declare;
import com.kh.styleblending.admin.model.vo.PageInfo;
import com.kh.styleblending.admin.model.vo.Statistics;
import com.kh.styleblending.main.model.vo.Notice;
import com.kh.styleblending.member.model.vo.Member;
import com.kh.styleblending.posting.model.vo.Hash;
import com.kh.styleblending.posting.model.vo.Style;

@Repository("aDao")
public class AdminDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int selectNewBcount() {
		return sqlSession.selectOne("adminMapper.selectNewBcount");
	}
	
	public ArrayList<Member> selectNewMember() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectNewMember");
	}
	
	public int selectNoCheckDeclare() {
		return sqlSession.selectOne("adminMapper.selectDeclareCount");
	}
	
	public Ad selectStartAd() {
		return sqlSession.selectOne("adminMapper.selectStartAd");
	}
	
	public int getMemberListCount(String keyword) {
		return sqlSession.selectOne("adminMapper.getMemberListCount",keyword);
	}
	
	public ArrayList<Member> selectMemberList(PageInfo pi, String keyword){
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectMemberList", keyword, rowBounds);
	}
	
	public int deleteMember(ArrayList mno) {
	
		return sqlSession.update("adminMapper.deleteMember", mno);
	}
	
	public int getDeclareListCount(HashMap cate) {
		
		return sqlSession.selectOne("adminMapper.getDeclareListCount",cate);			
		
	}
	
	public ArrayList<Declare> selectDeclareList(PageInfo pi, HashMap cate){
		
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectDeclareList", cate, rowBounds);
	}
	
	public int deleteDeclareBoard(ArrayList dno) {
		return sqlSession.update("adminMapper.deleteDeclareBoard",dno);
	}
	
	public int pDeleteBoard(int bno) {
		return sqlSession.update("adminMapper.pDeleteBoard",bno);
	}
	
	public int bDeleteBoard(int bno) {
		return sqlSession.update("adminMapper.bDeleteBoard",bno);
	}
	
	public int updateIsCheck(String dno) {
		return sqlSession.update("adminMapper.updateIsCheck", dno);
	}
	
	public int getAdListCount(HashMap<?, ?> map) {
		// 총 광고수 조회
		return sqlSession.selectOne("adminMapper.getAdListCount", map);
	}

	public ArrayList<Ad> selectAdList(PageInfo pi, HashMap<?, ?> map) {
		// 광고 목록조회
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("adminMapper.selectAdList", map, rowBounds);
	}
	
	public ArrayList<Ad> selectAdNewList(){
		return (ArrayList)sqlSession.selectList("adminMapper.selectAdNewList");
	}
	
	public int insertAd(Ad ad) {
		return sqlSession.insert("adminMapper.insertAd",ad);
	}
	
	public int insertPay(Ad ad) {
		return sqlSession.insert("adminMapper.insertPay",ad);
	}
	
	public int updateStartAd(String adno) {
		return sqlSession.update("adminMapper.updateStartAd",adno);
	}
	
	public int updateEndAd() {
		return sqlSession.update("adminMapper.updateEndAd");
	}
	
	public ArrayList<Statistics> selectMemberCount() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectMemberCount");
	}
	
	public ArrayList<Statistics> selectDayCount() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectDayCount");
	}
	
	public ArrayList<Statistics> totalCount() {
		return (ArrayList)sqlSession.selectList("adminMapper.totalCount");
	}
	
	public ArrayList<Hash> selectHashRank() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectHashRank");
	}
	
	public ArrayList<Style> selectCateRank() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectCateRank");
	}
	
	public ArrayList<Style> selectBrandRank() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectBrandRank");
	}
	
	public ArrayList<Style> selectColorRank() {
		return (ArrayList)sqlSession.selectList("adminMapper.selectColorRank");
	}
	
	public int getNoticeListCount() {
		return sqlSession.selectOne("adminMapper.getNoticeListCount");
	}

	public ArrayList<Notice> selectNoticeAdminList(PageInfo pi) {
		
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset,pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("adminMapper.selectNoticeList",null,rowBounds);
	}
	
	public ArrayList<Notice> selectNoticeList() {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectNoticeList");
	}
	
	
}
