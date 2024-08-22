          PROGRAM foldmap  

          Real*4 rec_X(1000000), rec_y(1000000)
          Real*4 sou_x(1000000),sou_y(1000000)
          CHARACTER*80 CL1,CSTR,VER
          
c------------------Defaults--------------------

          apert=8000.
          d=0.
          z=200.
          vpvs=3

c---------------------------------------------------------------------------------------
          Open (unit=9,file='nodes',status='old')
          Open (unit=10,file='shots',status='old')
          Open (unit=11,file='cmps_up')
          Open (unit=12,file='cmps_mirror')
          Open (unit=13,file='cmps1_ps')
c------------------------------------------------------------------------

          nnodes=0
          nshots=0

          Read(9,*)dummy
          Do i=1,100000
          Read(9,*,end=9999)Rec_x(i),Rec_y(i)
          nnodes= nnodes+1
          Enddo
9999      Continue
          Read(10,*)dummy
          Do j=1,1000000
          Read(10,*,end=8888) sou_x(j),sou_y(j)
          nshots=nshots+1
          Enddo
8888      Continue
          Write(*,*)'# of nodes',nnodes,'# of shots',nshots
          pi=3.14159
          Do i=1,nnodes
              num_shots=0
              Do j=1,nshots
              xx= (sou_x(j)-rec_x(i))
              yy= (sou_y(j)-rec_y(i))
              Offset=sqrt(xx**2+yy**2)
             azim = 90.-(atan2(yy,xx))*(180. / pi)
              taniu_x= (xx)/(2*Z+d)
              taniu_y= (yy)/(2*Z+d)
              tanid_x= (xx)/(2*Z+3*d)
              tanid_y= (yy)/(2*Z+3*d)
c
              dxu= taniu_x*Z
              dyu= taniu_y*Z
              dxd= tanid_x*(Z+2*d)
              dyd= tanid_y*(Z+2*d)
              dxs1= xx/(1+vpvs)
              dys1= yy/(1+vpvs)
c
              cmpu_x=rec_x(i)+dxu
              cmpu_y=rec_y(i)+dyu
              cmpd_x=rec_x(i)+dxd
              cmpd_y=rec_y(i)+dyd
              cmps1_x=rec_x(i)+dxs1
              cmps1_y=rec_y(i)+dys1
c
              If (offset .le. apert)then
               num_shots=num_shots+1             
                 write(11,*)cmpu_x,cmpu_y,offset,azim
                 write(12,*)cmpd_x,cmpd_y,offset,azim
                 write(13,*)cmps1_x,cmps1_y,offset,azim

              Endif

          Enddo
c          write(14,*)i,num_shots
          Enddo

          Stop
          End      






