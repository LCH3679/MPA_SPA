package org.iot.mapper;

import java.util.List;

import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;



public interface BoardMapper {

	public List<BoardVO> getList(Criteria cri);
	
	public Integer insertSelectKey(BoardVO board);

	public BoardVO read(String busi_num);

	public int delete(String busi_num);

	public int update(BoardVO board);
	
	public int updateAccount(BoardVO board);

	/* public List<BoardVO> getListWithPaging(Criteria cri); */

	

	/* public int getTotalCount(Criteria cri); */
}
