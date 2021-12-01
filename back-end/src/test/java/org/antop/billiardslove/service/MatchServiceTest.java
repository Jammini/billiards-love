package org.antop.billiardslove.service;

import org.antop.billiardslove.dao.MatchDao;
import org.antop.billiardslove.dao.MemberDao;
import org.antop.billiardslove.dto.MatchDto;
import org.antop.billiardslove.dto.MatchPlayerDto;
import org.antop.billiardslove.jpa.entity.Match;
import org.antop.billiardslove.jpa.entity.Member;
import org.antop.billiardslove.jpa.entity.Player;
import org.antop.billiardslove.mapper.MatchMapperImpl;
import org.antop.billiardslove.mapper.MatchPlayerMapperImpl;
import org.antop.billiardslove.model.Outcome;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.TestConstructor;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Field;
import java.util.Objects;
import java.util.Optional;

import static com.github.npathai.hamcrestopt.OptionalMatchers.isPresent;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(SpringExtension.class)
@Import({MatchService.class, MatchMapperImpl.class, MatchPlayerMapperImpl.class})
@TestConstructor(autowireMode = TestConstructor.AutowireMode.ALL)
class MatchServiceTest {
    @MockBean
    private MemberDao memberDao;
    @MockBean
    private MatchDao matchDao;

    private final MatchService matchService;

    public MatchServiceTest(MatchService matchService) {
        this.matchService = matchService;
    }

    @DisplayName("회원이 경기를 조회")
    @Test
    void getMatchByMember() {
        /*
         * 왼쪽 선수가 회원7, 오른쪽 선수가 회원8인 상태
         * 회원8이 조회시 왼쪽이 회원8, 오른쪽이 회원7로 나와야 한다.
         */
        // given
        final long matchId = 118L;
        final long memberId = 8L;
        Member member = mock(Member.class);
        when(member.getId()).thenReturn(memberId);
        when(member.isManager()).thenReturn(false);
        when(memberDao.findById(anyLong())).thenReturn(Optional.of(member));
        doReturn(Optional.of(match())).when(matchDao).findById(anyLong());
        // when
        Optional<MatchDto> optional = matchService.getMatch(matchId, memberId);
        // then
        assertThat(optional, isPresent());
        optional.ifPresent(it -> {
            MatchPlayerDto left = it.getLeft();
            assertThat(left.getId(), is(291L));
            assertThat(left.getNickname(), is("띠용"));
            assertThat(left.getResult(), is(new String[]{"LOSE", "LOSE", "WIN"}));

            MatchPlayerDto right = it.getRight();
            assertThat(right.getId(), is(192L));
            assertThat(right.getNickname(), is("안탑"));
            assertThat(right.getResult(), is(new String[]{"WIN", "WIN", "LOSE"}));
        });
    }

    @DisplayName("관리자가 경기를 조회")
    @Test
    void getMatchByManager() {
        /*
         * 왼쪽 선수가 회원7, 오른쪽 선수가 회원8인 상태
         * 내가 회원8이라도 관리자면 조회시 왼쪽이 회원7, 오른쪽이 회원8로 그대로 나와야 한다.
         */
        // given
        final long matchId = 118L;
        final long memberId = 8L;
        Member member = mock(Member.class);
        when(member.getId()).thenReturn(memberId);
        when(member.isManager()).thenReturn(true); // 관리자
        when(memberDao.findById(anyLong())).thenReturn(Optional.of(member));
        doReturn(Optional.of(match())).when(matchDao).findById(anyLong());
        // when
        Optional<MatchDto> optional = matchService.getMatch(matchId, memberId);
        // then
        assertThat(optional, isPresent());
        optional.ifPresent(it -> {
            MatchPlayerDto left = it.getLeft();
            assertThat(left.getId(), is(192L));
            assertThat(left.getNickname(), is("안탑"));
            assertThat(left.getResult(), is(new String[]{"WIN", "WIN", "LOSE"}));

            MatchPlayerDto right = it.getRight();
            assertThat(right.getId(), is(291L));
            assertThat(right.getNickname(), is("띠용"));
            assertThat(right.getResult(), is(new String[]{"LOSE", "LOSE", "WIN"}));
        });
    }

    /**
     * Stub
     */
    private Match match() {
        Field idField = ReflectionUtils.findField(Member.class, Member.Fields.ID);
        Objects.requireNonNull(idField).setAccessible(true);

        Member m1 = Member.builder().nickname("안탑").build();
        ReflectionUtils.setField(idField, m1, 7L);

        Member m2 = Member.builder().nickname("띠용").build();
        ReflectionUtils.setField(idField, m2, 8L);

        Player p1 = mock(Player.class);
        when(p1.getId()).thenReturn(192L);
        when(p1.getMember()).thenReturn(m1);

        Player p2 = mock(Player.class);
        when(p2.getId()).thenReturn(291L);
        when(p2.getMember()).thenReturn(m2);

        Match match = Match.builder().player1(p1).player2(p2).build();
        match.enterResult(m1.getId(), Outcome.WIN, Outcome.WIN, Outcome.LOSE);
        match.enterResult(m2.getId(), Outcome.LOSE, Outcome.LOSE, Outcome.WIN);

        return match;
    }

}
