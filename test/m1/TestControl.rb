# TestControl.rb
class TestControl
    @m_curfunc = nil
    @m_nextfunc = nil
    @m_bNoWait = false

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
                case @m_curfunc
                    # [STATEGO OUTPUT START] indent(20) $/^S_/->#case$
                    #             psggConverterLib.dll converted from psgg-file:TestControl.psgg

                    when 'S_0000'
                        S_0000(bFirst)
                    when 'S_END'
                        S_END(bFirst)
                    when 'S_START'
                        S_START(bFirst)


                    # [STATEGO OUTPUT END] 
                end
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
        # tbi
    end

    def returnState
        #tbi
    end

    def run
        puts '[START OF RUNNING]'
        goto('S_START')
        loopmax = 50000
        loopmax.times do |count|
            if count >= loopmax - 1 then
                puts "error : out of loop"
                break
            end
            update()
            if checkState('S_END') then
                puts "[END OF RUNNING]"
                break
            end
        end
    end

    # [STATEGO OUTPUT START] indent(4) $/^S_/$
    #             psggConverterLib.dll converted from psgg-file:TestControl.psgg

    #
    #    S_0000
    #
    #
    def S_0000(bFirst)
        if bFirst then
            puts "Hello World."
        end
        if hasNextState() == false then
            goto('S_END')
        end
    end
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
        goto('S_0000')
        noWait()
    end


    # [STATEGO OUTPUT END]
end