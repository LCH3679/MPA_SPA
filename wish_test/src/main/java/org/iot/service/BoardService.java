package org.iot.service;

import java.util.List;

import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;;



public interface BoardService {
	
	public void register(BoardVO board);
	
	public void register(AccountVO account);

	public BoardVO get(String busi_num);

	public boolean modify(BoardVO board);
	
	public boolean modifyAccount(BoardVO board);

	public boolean remove(String busi_num);

	public List<BoardVO> getList(Criteria cri);
}
