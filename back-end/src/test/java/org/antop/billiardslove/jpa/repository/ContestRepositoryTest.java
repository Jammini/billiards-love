package org.antop.billiardslove.jpa.repository;

import org.antop.billiardslove.core.ProgressStatus;
import org.antop.billiardslove.jpa.DataJpaTest;
import org.antop.billiardslove.jpa.entity.Contest;
import org.antop.billiardslove.jpa.entity.Manager;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;

@DisplayName("대회 테스트")
class ContestRepositoryTest extends DataJpaTest {

    @Autowired
    private ManagerRepository managerRepository;

    @Autowired
    private ContestRepository contestRepository;

    @Test
    @DisplayName("대회 데이터를 조회")
    void select() {
        Optional<Contest> contestOptional = contestRepository.findById(1L);
        assertThat(contestOptional.isPresent(), is(true));
        Contest contest = contestOptional.get();
        assertThat(contest.getTitle(), is("2019 리그전"));
        assertThat(contest.getDescription(), is("2020.01.01~"));
        assertThat(contest.getStartDate(), is(LocalDate.of(2019, 1, 1)));
        assertThat(contest.getStartTime(), is(LocalTime.of(0, 0, 0)));
        assertThat(contest.getEndDate(), is(LocalDate.of(2019, 12, 30)));
        assertThat(contest.getEndTime(), is(LocalTime.of(23, 59, 59)));
        assertThat(contest.getMaximumParticipants(), is(64));
        assertThat(contest.getProgressStatus(), is(ProgressStatus.END));
    }

    @Test
    @DisplayName("데이터베이스 스텁을 통해 SQL문이 정상적으로 잘 들어갔는지 사이즈 체크")
    void AE07R4() {
        List<Contest> list = contestRepository.findAll();
        assertThat(list, hasSize(3));
    }

    @Test
    @DisplayName("대회 데이터를 등록한다.")
    void insert() {
        Optional<Manager> managerOptional = managerRepository.findById(1L);

        Contest contest = Contest.builder()
                .title("코로나 리그전 2020")
                .description("1등 상품 맥북")
                .startDate(LocalDate.of(2020, 12, 25))
                .startTime(LocalTime.of(10, 0))
                .endDate(LocalDate.of(2021, 1, 31))
                .endTime(LocalTime.of(12, 0))
                .maximumParticipants(16)
                .registrationUser(managerOptional.get())
                .build();
        contestRepository.save(contest);

        Optional<Contest> contestOptional = contestRepository.findById(4L);
        assertThat(contestOptional.isPresent(), is(true));
        Contest contest1 = contestOptional.get();
        assertThat(contest1.getTitle(), is("코로나 리그전 2020"));
        assertThat(contest1.getDescription(), is("1등 상품 맥북"));
        assertThat(contest1.getStartDate(), is(LocalDate.of(2020, 12, 25)));
        assertThat(contest1.getStartTime(), is(LocalTime.of(10, 0)));
        assertThat(contest1.getEndDate(), is(LocalDate.of(2021, 1, 31)));
        assertThat(contest1.getEndTime(), is(LocalTime.of(12, 0)));
        assertThat(contest1.getMaximumParticipants(), is(16));
        assertThat(contest1.getProgressStatus(), is(ProgressStatus.ACCEPTING));
        assertThat(contest1.getRegistrationUser(), is(managerOptional.get()));
    }

    @Test
    @DisplayName("대회 데이터를 갱신한다.")
    void J6l1Z() {
        contestRepository.findById(2L).ifPresent(it -> {
            it.setTitle("2020 리그전 - 2");
            it.setDescription("2020년 2번째 리그전 코로나로 인해 종료");
            it.setProgressStatus(ProgressStatus.END);
        });

        Optional<Contest> contestOptional = contestRepository.findById(2L);
        assertThat(contestOptional.isPresent(), is(true));
        Contest contest = contestOptional.get();
        assertThat(contest.getTitle(), is("2020 리그전 - 2"));
        assertThat(contest.getDescription(), is("2020년 2번째 리그전 코로나로 인해 종료"));
        assertThat(contest.getProgressStatus(), is((ProgressStatus.END)));
    }

}
