#!/bin/env nu
#
#  add an enum of available (kill) signals

export-env {
    # taken from man signal
    let SIGNALS = [
        { number:1,name: "SIGHUP", description: "terminate process - terminal line hangup"}
        { number:2,name: "SIGINT", description: "terminate process - interrupt program"}
        { number:3,name: "SIGQUIT", description: "create core -     quit program"}
        { number:4,name: "SIGILL", description: "create core -     illegal instruction"}
        { number:5,name: "SIGTRAP", description: "create core -     trace trap"}
        { number:6,name: "SIGABRT", description: "create core -     abort program (formerly SIGIOT)"}
        { number:7,name: "SIGEMT", description: "create core -     emulate instruction executed"}
        { number:8,name: "SIGFPE", description: "create core -     floating-point exception"}
        { number:9,name: "SIGKILL", description: "terminate process - kill program"}
        { number:10,name: "SIGBUS", description: "create core -     bus error"}
        { number:11,name: "SIGSEGV", description: "create core -     segmentation violation"}
        { number:12,name: "SIGSYS", description: "create core -     non-existent system call invoked"}
        { number:13,name: "SIGPIPE", description: "terminate process - write on a pipe with no reader"}
        { number:14,name: "SIGALRM", description: "terminate process - real-time timer expired"}
        { number:15,name: "SIGTERM", description: "terminate process - software termination signal"}
        { number:16,name: "SIGURG", description: "discard signal - urgent condition present on socket"}
        { number:17,name: "SIGSTOP", description: "stop process - stop (cannot be caught or ignored)"}
        { number:18,name: "SIGTSTP", description: "stop process - stop signal generated from keyboard"}
        { number:19,name: "SIGCONT", description: "discard signal - continue after stop"}
        { number:20,name: "SIGCHLD", description: "discard signal - child status has changed"}
        { number:21,name: "SIGTTIN", description: "stop process - background read attempted from control terminal"}
        { number:22,name: "SIGTTOU", description: "stop process - background write attempted to control terminal"}
        { number:23,name: "SIGIO", description: "discard signal - I/O is possible on a descriptor (see fcntl(2))"}
        { number:24,name: "SIGXCPU", description: "terminate process - cpu time limit exceeded (see setrlimit(2))"}
        { number:25,name: "SIGXFSZ", description: "terminate process - file size limit exceeded (see setrlimit(2))"}
        { number:26,name: "SIGVTALRM", description: "terminate process - virtual time alarm (see setitimer(2))"}
        { number:27,name: "SIGPROF", description: "terminate process - profiling timer alarm (see setitimer(2))"}
        { number:28,name: "SIGWINCH", description: "discard signal - Window size change"}
        { number:29,name: "SIGINFO", description: "discard signal - status request from keyboard"}
        { number:30,name: "SIGUSR1", description: "terminate process - User defined signal 1"}
        { number:31,name: "SIGUSR2", description: "terminate process - User defined signal 2"}
    ]
    $env.SIG = $SIGNALS
}

export def main [] {
    $env.SIG
}
