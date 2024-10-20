{
  Column[
    {
      Naigator[
        {
          Column
          [
            AppBar
            height : 72
            [
              {
                Row[
                  {
                    Text
                    name : shop_one
                    alignment : bottomCenter
                    marginTop :8
                    marginBottom:5
                  }
                  {
                    CustoomButton
                    decoration : btnFillOnPrimaryContainer
                    name : find
                    alignment : center
                    marginLeft: 16
                  }
                ]
              }
            ]
          ]
        }
        {
          VerticalScroll
          alignment : center
          [
            {
              Column
              alignment : center
              paddingLeft : 32
              paddingRight : 32
              paddingTop : 38
              paddingBottom :38
              [
                {
                  View
                  name : view_two
                  alignment : center
                  height : 266
                }
                {
                  Row
                  alignment : center
                  marginRight: 4
                  marginTop :22
                  horizontalAlignment : center
                  {
                    Text
                    name : add_one
                    alignment : center
                    paddingLeft : 16
                    paddingRight : 16
                    paddingTop : 8
                    paddingBottom :8

                  }
                  {
                    CustoomButton
                    decoration : btnOutlinePrimary
                    name : sell
                    alignment : center
                    
                  }
                  {
                    Text
                    name : search_one
                    alignment : center
                    paddingLeft : 16
                    paddingRight : 16
                    paddingTop : 8
                    paddingBottom :8
                  }
                }
              ]
              {
                Row
                alignment : center
                marginTop :18
                [
                  {
                  Stack
                  alignment : center
                  height : 64
                  [
                    {
                      Image 
                      name : image_one
                      alignment : center
                      height : 32
                    }
                  ]
                  {
                      Stack
                  alignment : center
                  height : 64
                  [
                    {
                      Image 
                      name : upsellingone
                      alignment : center
                      height : 32
                    }
                  ]
                  
                  }
                  {
                    Stack
                  alignment : center
                  height : 56
                  [
                    {
                      Image 
                      name : loupeone_one
                      alignment : center
                      height : 24
                    }
                  ]
                  }
                  

                  }
                ]

              }
              {
                View
                name : view_one
                alignment : center
                heigt :84
                marginTop : 78
                marginBottom : 4
              }
            }
          ]
        }
      ]
    }
  ]
}