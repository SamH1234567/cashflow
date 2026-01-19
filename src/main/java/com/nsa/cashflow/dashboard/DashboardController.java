package com.nsa.cashflow.dashboard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DashboardController {

    @GetMapping("/dashboard")
    public ModelAndView dashboard() {
        ModelAndView mav = new ModelAndView("dashboard");
        return mav;
    }
}
