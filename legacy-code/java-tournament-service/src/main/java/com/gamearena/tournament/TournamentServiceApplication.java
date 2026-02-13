package com.gamearena.tournament;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Game Arena Tournament Service - Legacy Application
 * Built with Spring Boot 2.7 (needs modernization to 3.x)
 */
@SpringBootApplication
public class TournamentServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(TournamentServiceApplication.class, args);
        System.out.println("🎮 Tournament Service (Legacy) started on port 8080");
        System.out.println("⚠️  WARNING: This version uses blocking I/O and outdated dependencies");
    }
}
