# TestControl.rb
class TestControl

    MAX_CALL_STACK = 10

    def initialize
        @m_curfunc = nil
        @m_nextfunc = nil
        @m_bNoWait = false

                      # 1   2   3   4   5   6   7   8   9   10
        @m_callstack = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
        @m_callstack_level = 0
    end

    def update
        while true 
            bFirst = true
            if @m_nextfunc != nil then
                @m_curfunc = @m_nextfunc
                @m_nextfunc = nil
                bFirst = true
            end

            @m_bNoWait = false
            if @m_curfunc != nil then
                @m_curfunc.call(bFirst)            
            end

            if @m_bNoWait == false then
                break
            end
        end
    end

    def goto(st)
        @m_nextfunc = st
    end

    def checkState(st)
        return @m_curfunc == st
    end

    def noWait
        @m_bNoWait = true
    end

    def hasNextState
        return @m_nextfunc != nil
    end

    def goSubState(sub,nex)
        if @m_callstack_level >= (MAX_CALL_STACK-1) then
            puts('CALL STACK OVER FLOW')
        else
            @m_callstack[@m_callstack_level] = nex
            @m_callstack_level += 1
            goto( sub )
        end
    end

    def returnState
        st = nil
        if @m_callstack_level <= 0 then
            puts('CALL STACK UNDER FLOW')
        else
            @m_callstack_level -= 1
            st = @m_callstack[@m_callstack_level]
            goto( st )
        end
    end

    def run
        puts "[START OF RUNNING]"
        puts ""
        
        goto(self.method(:S_START))
        loopmax = 50000
        loopmax.times do |count|
            if count >= loopmax - 1 then
                puts "error : out of loop"
                break
            end
            update()
            if checkState(self.method(:S_END)) then
                puts ""
                puts "[END OF RUNNING]"
                break
            end
        end
    end

    # Embed code
    # [STATEGO OUTPUT START] indent(4) $/^E_/$
    #             psggConverterLib.dll converted from psgg-file:TestControl.psgg



    # [STATEGO OUTPUT END]

    # State methods
    # [STATEGO OUTPUT START] indent(4) $/^S_/$
    #             psggConverterLib.dll converted from psgg-file:TestControl.psgg

    #
    #    S_END
    #
    #
    def S_END(bFirst)
        # nothing
    end
    #
    #    S_START
    #
    #
    def S_START(bFirst)
        goto(self.method(:S_END))
        noWait()
    end


    # [STATEGO OUTPUT END]
end