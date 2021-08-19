package org.antop.billiardslove.api;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.antop.billiardslove.config.security.JwtAuthenticationToken;
import org.antop.billiardslove.dto.ContestDto;
import org.antop.billiardslove.exception.ContestNotFoundException;
import org.antop.billiardslove.service.ContestService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 대회 API
 *
 * @author jammini
 */
@Slf4j
@RequiredArgsConstructor
@RestController
public class ContestInfoApi {
    private final ContestService contestService;

    /**
     * 대회 정보 한건 조회
     */
    @GetMapping("/api/v1/contest/{id}")
    public ContestDto info(@PathVariable(name = "id") long contestId) {
        return contestService.getContest(contestId).orElseThrow(ContestNotFoundException::new);
    }

    /**
     * 대회 목록 조회
     */
    @GetMapping("/api/v1/contests")
    public List<ContestDto> list() {
        return contestService.getAllContests();
    }

    /**
     * 대회 등록
     */
    @Secured(JwtAuthenticationToken.ROLE_MANAGER)
    @PostMapping("/api/v1/contest")
    public ContestDto register(@RequestBody ContestDto dto) {
        // TODO(안정용): 201 응답
        return contestService.register(dto);
    }

    /**
     * 대회 정보 수정
     */
    @Secured(JwtAuthenticationToken.ROLE_MANAGER)
    @PutMapping("/api/v1/contest/{id}")
    public ContestDto modify(@PathVariable(name = "id") long contestId,
                             @RequestBody ContestDto dto) {
        ContestDto modify = contestService.modify(contestId, dto);
        return modify;
    }

}
