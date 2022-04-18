package org.iot.service;

import java.util.List;

import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;
import org.iot.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {

		log.info("register......" + board);

		 mapper.insertSelectKey(board);
	}
	
	
	@Override
	public void register(AccountVO account) {
		// TODO Auto-generated method stub
		mapper.insert(account);
	}

	
	

	@Override
	public BoardVO get(String busi_num) {

		log.info("get......" + busi_num);

		return mapper.read(busi_num);

	}

	@Override
	public boolean modify(BoardVO board) {

		log.info("modify......" + board);

		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(String busi_num) {

		log.info("remove...." + busi_num);

		return mapper.delete(busi_num) == 1;
	}

	// @Override
	// public List<BoardVO> getList() {
	//
	// log.info("getList..........");
	//
	// return mapper.getList();
	// }

	/*
	 * @Override public List<BoardVO> getList(Criteria cri) {
	 * 
	 * log.info("get List with criteria: " + cri);
	 * 
	 * return mapper.getListWithPaging(cri); }
	 */
	/*
	 * @Override public int getTotal(Criteria cri) {
	 * 
	 * log.info("get total count"); return mapper.getTotalCount(cri); }
	 */
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getList(cri);
	}


	@Override
	public boolean modifyAccount(BoardVO board) {
		// TODO Auto-generated method stub
		return mapper.updateAccount(board) == 1;
	}
	
}
