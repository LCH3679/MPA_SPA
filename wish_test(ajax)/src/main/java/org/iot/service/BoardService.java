package org.iot.service;

import java.util.List;

import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;;



public interface BoardService {
	
	public int register(BoardVO board);
	
	public BoardVO get(String busi_num);

	public int modify(BoardVO board);
	
	public int modifyAccount(BoardVO board);

	public int remove(String busi_num);

	public List<BoardVO> getList(Criteria cri);
}
