package org.iot.controller;


import org.iot.domain.AccountVO;
import org.iot.domain.BoardVO;
import org.iot.domain.Criteria;
import org.iot.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
	@GetMapping("/register")
	public void register() {

	}
	
	 @GetMapping("/list")
	 public void list(Criteria cri , Model model) {
	
	 log.info("list");
	 model.addAttribute("list", service.getList(cri));
	 }


	@PostMapping("/register")
	public String register(BoardVO board, AccountVO account, RedirectAttributes rttr) {

		log.info("register: " + board);

		service.register(board);
		service.register(account);
		rttr.addFlashAttribute("result", board.getBusi_num());
		rttr.addFlashAttribute("result", account.getBusi_num());

		return "redirect:/board/list";
	}

	  @GetMapping({ "/get", "/modify" }) public void get(@RequestParam("busi_num") String busi_num, Model model) {
	 
	  log.info("/get or modify "); 
	  model.addAttribute("board", service.get(busi_num));
	 
	 }
	

	 @PostMapping("/modify")
	 public String modify(BoardVO board, RedirectAttributes rttr) {
	 log.info("modify:" + board);
	
	 if (service.modify(board) && service.modifyAccount(board)) {
	 rttr.addFlashAttribute("result", "success");
	 }
	 return "redirect:/board/list";
	 }

	 @PostMapping("/remove")
	 public String remove(@RequestParam("busi_num") String busi_num, RedirectAttributes rttr)
	 {
	
	 log.info("remove..." + busi_num);
	 if (service.remove(busi_num)) {
	 rttr.addFlashAttribute("result", "success");
	 }
	 return "redirect:/board/list";
	 }
}
