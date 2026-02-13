package com.gamearena.tournament.repository;

import com.gamearena.tournament.model.Tournament;
import com.gamearena.tournament.model.TournamentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Legacy JPA Repository - BLOCKING I/O
 * Needs migration to ReactiveCrudRepository with R2DBC
 */
@Repository
public interface TournamentRepository extends JpaRepository<Tournament, Long> {
    
    /**
     * Find tournaments by status - BLOCKING call
     */
    List<Tournament> findByStatus(TournamentStatus status);
    
    /**
     * Find tournaments by game - BLOCKING call
     */
    List<Tournament> findByGame(String game);
    
    /**
     * Find tournaments with open registration - BLOCKING call
     */
    List<Tournament> findByStatusAndCurrentParticipantsLessThan(
        TournamentStatus status, 
        Integer maxParticipants
    );
}
