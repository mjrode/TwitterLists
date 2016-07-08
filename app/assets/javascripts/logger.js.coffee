@Logger = (->

  log_on = true

  log: (msg, force)->
    if (log_on or force) and console?
      console.log msg 
    msg
  
  err: (msg)->
    if log_on and console?
      console.error msg
    msg
      
  logit: (bool)->
    log_on = bool

  )()
  
window.err = Logger.err
window.log = Logger.log
window.p = (msg)-> log(msg, true)
window.puts = p
  
  
