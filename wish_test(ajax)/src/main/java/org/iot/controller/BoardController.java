package org.iot.controller;

import java.util.List;

import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;
import org.iot.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/board/*")
@RestController
@Log4j
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	@GetMapping("")
	 public void list(Criteria cri , Model model) {
	
	 log.info("list");
	 model.addAttribute("list", service.getList(cri));
	 }
	
	@PostMapping(value = "/register.do", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<? extends Object> create(@RequestBody BoardVO vo) {
		
		log.info("BoardVO: " + vo);
		int insertCount = service.register(vo);

		return insertCount == 2
				?  new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/{busi_num}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<BoardVO> get(@PathVariable("busi_num") String busi_num) {

		log.info("get: " + busi_num);

		return new ResponseEntity<>(service.get(busi_num), HttpStatus.OK);
	}

	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{busi_num}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<? extends Object> modify( @RequestBody BoardVO board, @PathVariable("busi_num") String busi_num) {

		board.setBusi_num(busi_num);

		log.info("busi_num: " + busi_num);
		log.info("modify: " + board);

		return service.modify(board) == 1 && service.modifyAccount(board) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	@DeleteMapping(value = "/{busi_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<? extends Object> remove(@PathVariable("busi_num") String busi_num) {
		
		log.info("remove: " + busi_num);

		return service.remove(busi_num) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	 @GetMapping(value = "/pages", 
			 produces = { MediaType.APPLICATION_XML_VALUE,
					 MediaType.APPLICATION_JSON_UTF8_VALUE })
	 public ResponseEntity<List<BoardVO>> getList( ) {
		 
		 Criteria cri = new Criteria();
		 log.info("getList.................");
		 log.info(cri);
	
	 return new ResponseEntity<>(service.getList(cri) , HttpStatus.OK);
	 }
}

